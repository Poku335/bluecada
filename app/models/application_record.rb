class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  connects_to shards: {
    # pri: { writing: :primary },
    int: { writing: :internal },
    ext: { writing: :external }
  }

  # belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  # belongs_to :updater, class_name: "User", foreign_key: "updater_id"

  attr_accessor :current_user_id, :skip_callback

  def skip_callback?
    self.skip_callback
  end

  def as_json(params = {})
    params[:only] ||= []
    params[:except] ||= %i[created_at updated_at]
    params[:extra_cols] ||= []
    columns = self.class.column_names
    columns += params[:extra_cols]
    cols = params[:only].size > 0 ? params[:only] : columns
    cols = cols.map { |e| e.to_s } - (params[:except].map { |e| e.to_s } - params[:only].map { |e| e.to_s })
    hsh = super(only: cols, methods: params[:extra_cols])
    # hsh.merge!(creator_username:creator.nil? ? "" : creator.username) if self.class.column_names.include?("creator_id")
    # hsh.merge!(updater_username:updater.nil? ? "" : updater.username) if self.class.column_names.include?("updater_id")
    hsh
  end

  def to_s
    has_attribute?(:name) ? name : ""
  end

  def self.search(params = {})
    data = params[:data] || all.select(column_names.map{|c| "#{table_name}.\"#{c}\"" if !["created_at","updated_at"].include?(c)}.compact.join(","))

    # # creator, updater
    # if column_names.include?("creator_id")
    #   data = data.select "creators.username as creator_username"
    #   data = data.joins "left outer join users creators on creators.id = #{table_name}.creator_id"
    # end
    # if column_names.include?("updater_id")
    #   data = data.select "updaters.username as updater_username"
    #   data = data.joins "left outer join users updaters on updaters.id = #{table_name}.updater_id"
    # end

    # default params
    params[:keywords_columns] ||= ["#{table_name}.name"]

    # joins
    if params[:inner_joins].present?
      params[:inner_joins].each do |j|
        if j.instance_of?(Symbol) || j.instance_of?(String)
          tbname = j.to_s
          fkey = "#{tbname.singularize}_id"
        else 
          tbname = j[:table_name].to_s
          fkey = j[:foreign_key].to_s
        end
        data = data.joins "inner join #{tbname} on #{tbname}.id = #{table_name}.#{fkey}"
      end
    end

    if params[:left_joins].present?
      params[:left_joins].each do |j|
        if j.instance_of?(Symbol) || j.instance_of?(String)
          tbname = j.to_s
          fkey = "#{tbname.singularize}_id"
        else
          tbname = j[:table_name].to_s
          fkey = j[:foreign_key].to_s
        end
        data = data.joins "left join #{tbname} on #{tbname}.id = #{table_name}.#{fkey}"
      end
    end

    # filters
    if params[:omit_default_filters].blank?
      column_names.each do |cname|
        # data = data.where "#{table_name}.#{cname} = ?", params[cname.to_sym] if params[cname.to_sym].present?
        if params.has_key?(cname.to_sym)
          params[cname.to_sym] = nil if params[cname.to_sym].blank?
          data = data.where("#{table_name}.#{cname}" => params[cname.to_sym])
        end
        data = data.where "#{table_name}.#{cname} in (#{JSON.parse(params[("#{cname}s").to_sym].to_s).join(",")})" if cname.split("_").last == "id" && params[("#{cname}s").to_sym].present?
      end
    end

    # keywords
    if params[:keywords].present? && params[:keywords_columns].present?

      if params[:keywords_columns] == [:"patients.name || ' ' || patients.hos_no", :citizen_id, :id_finding]
    
        keywords = params[:keywords].split
    
        if keywords.length > 1
          first_key = params[:keywords].split(" ").first
          last_key = params[:keywords].split(" ").last
          encoded_first_key = Patient.encode_name(first_key)
          encoded_last_key = Patient.encode_name(last_key)
    
          matching_first_key_patient = Patient.where("name ILIKE :keyword", keyword: "%#{encoded_first_key}%")
          matching_last_key_patient = Patient.where("last_name ILIKE :keyword", keyword: "%#{encoded_last_key}%")
    
          if matching_first_key_patient.present? && matching_last_key_patient.present?
            params[:keywords] = "#{encoded_first_key} #{encoded_last_key}"
          else
            params[:keywords] = encoded_first_key
          end
        else
          encoded_keywords = Patient.encode_name(params[:keywords])
          
          matching_patient = Patient.where("first_name ILIKE :keyword OR last_name ILIKE :keyword OR hos_no ILIKE :keyword OR citizen_id ILIKE :keyword OR id_finding ILIKE :keyword", keyword: "%#{encoded_keywords}%")
    
          if matching_patient.present?
            params[:keywords] = encoded_keywords
          end
        end
      end
    
      params[:keywords].split(" ").each do |k|
        kw_sqls = []
        kws = []
        params[:keywords_columns].each do |cname|
          kw_sqls << "#{cname} ~* ?"
          kws << k
        end
        data = data.where(kw_sqls.join(" or "), *kws)
      end
    end

    # soft delete
    if column_names.include?("is_soft_deleted") && params[:is_soft_deleted].blank?
      data = data.where "#{table_name}.is_soft_deleted is null or #{table_name}.is_soft_deleted = false"
    end

    # get total data (before limit,offset)
    total_query = data
    total_query = total_query.except(:select).select("COUNT(*) as total")
    total_sql = total_query.to_sql

    order = params[:order]
    offset = params[:offset].to_i
    limit = params[:limit].to_i
    page = params[:page].to_i
    offset = (page - 1) * limit if page > 0

    data = data.order(order)
    data = data.offset(offset) if offset
    data = data.limit(limit) if limit > 0

    # use as_json instead of direct query
    if params[:use_as_json]
      results = connection.execute data.except(:select).to_sql
      columns = self.column_names
      columns += (params[:extra_cols] || [])
      results = results.map do |attr|
        if attr["id"].blank?
          attr.each { |k, _v| attr.delete(k) unless columns.include?(k) }
          obj = new attr
        else
          obj = find attr["id"]
        end
        obj.as_json(params[:as_json_option] ||= {})
      end
    else
      results = connection.execute data.to_sql
    end

    if params[:datatable]
      total = connection.execute total_sql
      if total.any?
        total_record = total[0]["total"].to_i
        total_page = limit == 0 ? 1 : (total_record.to_f / limit).ceil
        page = limit == 0 ? 1 : 1 + (offset / limit)

        results = {
          data: results.to_a,
          total: total_record,
          total_page: total_page,
          page: page,
          limit: limit,
          offset: offset,
        }
      else
        results = {
          data: [],
          total: 0,
          total_page: 0,
          page: 0,
          limit: limit,
          offset: offset,
        }
      end
    end

    # filter output keys resp_keys
    if params[:resp_keys].present?
      resp_keys = params[:resp_keys].map{|e| e.to_s.strip}
      arr_data = params[:datatable].blank? ? (results = results.to_a; results) : (results[:data] ||= [])
      arr_data.each {|e| e.keys.each{|k| e.delete(k) if !resp_keys.include?(k.to_s)} }
    end

    results
  end

  after_save :publish, if: :is_publish?
  after_destroy :publish, if: :is_publish?

  # publish to redis class's methods
  def self.publish(obj_id = nil, hsh_msg = {}, is_publish_all = true)
    ch_name = model_name.plural
    hsh_msg[:message] ||= "updated"
    hsh_msg["#{model_name.singular}_id"] = obj_id if obj_id

    # publish all
    if is_publish_all
      begin
        $redis.publish(ch_name, hsh_msg.to_json)
      rescue StandardError
        nil
      end
      p "publish to #{ch_name} , hsh_msg: #{hsh_msg}"
    end

    # publish one
    if obj_id
      ch_name_one = "#{ch_name}/#{obj_id}"
      begin
        $redis.publish(ch_name_one, hsh_msg.to_json)
      rescue StandardError
        nil
      end
      p "publish to #{ch_name_one} , hsh_msg: #{hsh_msg}"
    end
  end

  # publish to redis object's methods
  def publish(hsh_msg = {}, is_publish_all = true)
    self.class.publish(id, hsh_msg, is_publish_all)
  end

  def is_publish?
    false
  end

end