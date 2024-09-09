class Patient < ApplicationRecord
  belongs_to :hospital
  belongs_to :sex
  belongs_to :post_code
  belongs_to :address_code
  belongs_to :marital_status
  belongs_to :race
  belongs_to :religion
  belongs_to :health_insurance
  belongs_to :province
  belongs_to :district
  belongs_to :sub_distric
end
