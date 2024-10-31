class TopographyCode < ApplicationRecord
  
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
