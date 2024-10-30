class CaseType < ApplicationRecord

  def as_json(options = {})
    super(options.merge({except: [:created_at, :updated_at]}))
  end
  
end
