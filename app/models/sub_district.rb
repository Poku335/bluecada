class SubDistrict < ApplicationRecord
  belongs_to :district

  def self.search_sub_districts(params)
    district = params[:district_id].to_i
    sub_districts = SubDistrict.where(district_id: district)
    sub_districts
  end

end
