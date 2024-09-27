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
        cancer_forms: cancer_forms&.as_json(only: [:id, :primary, :is_editing, :treatment_follow_up_id, :information_diagnosis_id, :treatment_information_id, :cancer_information_id, :cancer_form_status_id])
      )
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

  def self.search(params = {})
    start_date = params[:start_date]
    start_time = params[:start_time] || '00:00:00'
    end_date = params[:end_date]
    end_time = params[:end_time] || '23:59:59'

    data = all

    data = data.select %(
      patients.*,
      cancer_forms.id AS cancer_form_id,
      cancer_forms.primary AS cancer_form_primary,
      cancer_forms.cancer_form_status_id AS cancer_form_status, 
      cancer_form_statuses.name AS cancer_form_status_name,
      cancer_informations.icd_10 AS icd_10,
      case_types.name AS case_type_name,
      users.name AS current_user_name,
      races.name AS race_name,
      hospitals.name AS hospital_name,
      sexes.name AS sex_name,
      post_codes.code AS post_code,
      address_codes.code AS address_code,
      marital_statuses.name AS marital_status_name,
      religions.name AS religion_name,
      health_insurances.name AS health_insurance_name,
      provinces.province_thai AS province_name,
      districts.district_thai_short AS district_name,
      sub_districts.sub_district_thai_short AS sub_district_name
    )

    params[:inner_joins] = %i[]
    params[:left_joins] = %i[races hospitals sexes post_codes address_codes marital_statuses religions 
                            health_insurances provinces districts sub_districts]
    data = data.joins('LEFT JOIN cancer_forms ON cancer_forms.patient_id = patients.id')
                .joins('LEFT JOIN cancer_form_statuses ON cancer_forms.cancer_form_status_id = cancer_form_statuses.id')
                .joins('LEFT JOIN users ON users.id = cancer_forms.current_user_id')
                .joins('LEFT JOIN cancer_informations ON cancer_forms.cancer_information_id = cancer_informations.id')
                .joins('LEFT JOIN case_types ON cancer_informations.case_type_id = case_types.id')
    params[:keywords_columns] = ["patients.id"]
    params[:order] = params[:order] || "patients.id"
    data = super(params.merge!(data: data))

  end
end

