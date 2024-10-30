class DiagnoseInformation < ApplicationRecord
  belongs_to :cancer_information

  def as_json(options = {})
    super(options.merge({except: [:created_at, :updated_at]}))
  end
  
end
