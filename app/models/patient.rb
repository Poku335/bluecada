class Patient < ApplicationRecord
  belongs_to :hospital, optional: true
  belongs_to :sex, optional: true
  belongs_to :post_code, optional: true
  belongs_to :address_code, optional: true
  belongs_to :marital_status, optional: true
  belongs_to :race, optional: true
  belongs_to :religion, optional: true
  belongs_to :health_insurance, optional: true
  belongs_to :province, optional: true
  belongs_to :district, optional: true
  belongs_to :sub_district, optional: true
  has_many :cancer_forms
  after_create :save_post_code_and_address_code

  validates :hos_no, uniqueness: true
  validates :citizen_id, uniqueness: true

  def as_json(options = {})
  cache_key = "patient_as_json_#{self.id}"
  Rails.logger.info("Fetching cache for key: #{cache_key}")
  Rails.cache.fetch(cache_key, expires_in: 12.hours) do
    Rails.logger.info("Cache miss for key: #{cache_key}")
    super(options.merge(except: [:hospital_id, :sex_id, :post_code_id, :address_code_id, :marital_status_id, :race_id, :religion_id, :health_insurance_id, :province_id, :district_id, :sub_district_id])).merge(
      hospital: hospital,
      sex: sex,
      post_code: post_code,
      address_code: address_code,
      marital_status: marital_status,
      race: race,
      religion: religion,
      health_insurance: health_insurance,
      province: province,
      district: district,
      sub_district: sub_district,
      cancer_forms: cancer_forms.as_json(only: [:id, :primary, :is_editing, :treatment_follow_up_id, :information_diagnosis_id, :treatment_information_id, :cancer_information_id, :cancer_form_status_id])
    )
    end
  end

  def save_post_code_and_address_code
    province = Province.find_by(id: self.province_id)&.province_thai
    district = District.find_by(id: self.district_id)&.district_thai_short
    sub_district = SubDistrict.find_by(id: self.sub_district_id)&.sub_district_thai_short
    post_code = PostCode.find_by(province:province, district:district, sub_district:sub_district)
    address_code = AddressCode.find_by(province:province, district:district, sub_district:sub_district)
    self.update(post_code_id: post_code&.id, address_code_id: address_code&.id)
  end

  def create_form_data
    treatment_follow_up = TreatmentFollowUp.create!
    information_diagnosis = InformationDiagnosis.create!
    treatment_information = TreatmentInformation.create!
    cancer_information = CancerInformation.create!
    
    primary_value = self.cancer_forms.count + 1

    CancerForm.create!(
      patient_id: self.id,
      primary: primary_value,
      is_editing: false,
      treatment_follow_up_id: treatment_follow_up.id,
      information_diagnosis_id: information_diagnosis.id,
      treatment_information_id: treatment_information.id,
      cancer_information_id: cancer_information.id,
      cancer_form_status_id: 1
    )
  end
end
