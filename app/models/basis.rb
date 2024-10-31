class Basis < ApplicationRecord
  def self.cached_basis
    Rails.cache.fetch('basis', expires_in: 12.hours) do
      Basis.all.to_a
    end
  end

  def as_json(options = {})
    super(options.merge(except: [:created_at, :updated_at]))
  end

  def self.search(params = {})  
    data = all
    data = data.select %(
      #{table_name}.id,
      #{table_name}.code || ' ' || #{table_name}.name as name,
      #{table_name}.code
    )

    params[:inner_joins] = %i[]
    
    params[:keywords_columns] = []
    params[:order] = params[:order] || "#{table_name}.id"

    data = super(params.merge!(data: data))
  end
  
end
