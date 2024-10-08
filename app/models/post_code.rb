class PostCode < ApplicationRecord

  def self.get_post_code(params)
    post_code = PostCode.find_by(province: params[:province], district: params[:district], sub_district: params[:sub_district])
    { post_code: post_code.code }
  end


end
