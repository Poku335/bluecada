class District < ApplicationRecord
  belongs_to :province

  def self.find_districts(params)
    province = params[:province_id].to_i
    districts = District.where(province_id: province)
    districts
  end

  def as_json(options = {})
    super(options.merge(include: :province))
  end

end
