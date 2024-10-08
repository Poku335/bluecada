class PostCode < ApplicationRecord

  def self.get_post_code(params)
    province = Province.find_by(id: params[:province_id])
    district = District.find_by(id: params[:district_id])
    sub_district = SubDistrict.find_by(id: params[:sub_district_id])
    post_code = PostCode.find_by(province: province&.province_thai, district: district&.district_thai_short, sub_district: sub_district&.sub_district_thai_short)
    if post_code.present?
      { post_code: post_code.code }
    else
      { error: "Post code not found" }
    end
  end

end
