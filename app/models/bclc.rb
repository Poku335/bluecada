class Bclc < ApplicationRecord
  def as_json(options = {})
    super().merge!()
  end

  def self.search(params = {})
    data = all

    data = data.select %(
      #{table_name}.*,
      #{table_name}.code || ' ' || #{table_name}.name as name
    )

    params[:inner_joins] = []
    params[:left_joins] = []
    params[:keywords_columns] = [ :name ]
    params[:order] = params[:order] || "#{table_name}.id"
    params[:use_as_json] = false

    super(params.merge!(data: data))
  end
end
