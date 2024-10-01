  require 'csv'
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
    params[:left_joins] = %i[races hospitals sexes post_codes address_codes marital_statuses 
                            religions health_insurances provinces districts sub_districts]
    data = data.joins('LEFT JOIN cancer_forms ON cancer_forms.patient_id = patients.id')
               .joins('LEFT JOIN cancer_form_statuses ON cancer_forms.cancer_form_status_id = cancer_form_statuses.id')
               .joins('LEFT JOIN users ON users.id = cancer_forms.current_user_id')
               .joins('LEFT JOIN cancer_informations ON cancer_forms.cancer_information_id = cancer_informations.id')
               .joins('LEFT JOIN case_types ON cancer_informations.case_type_id = case_types.id')
    params[:keywords_columns] = ["patients.name", "patients.hos_no", :citizen_id, :id_finding]
    params[:order] = params[:order] || "patients.id"
    data = super(params.merge!(data: data))

  end

  def self.import_patient(params)
    if params[:file].present?
      file = params[:file]
      csv_file_path = file.path
      errors = []
      total_patient_count = 0
      new_patient_count = 0
      error_patient_count = 0
  
      CSV.foreach(csv_file_path, headers: true, encoding: 'bom|utf-8') do |row|
        total_patient_count += 1
        begin
          add_code = AddressCode.find_by(code: row['AddCode'])
          add_code_id = add_code&.id
          if add_code_id.nil?
            errors << "Address Code '#{row['AddCode']}' ไม่ถูกต้อง"
            error_patient_count += 1
            next
          end
  
          post_code = PostCode.find_by(code: row['Post'])
          post_code_id = post_code&.id
          if post_code_id.nil?
            errors << "รหัสไปรษณีย์ '#{row['Post']}' ไม่ถูกต้อง"
            error_patient_count += 1
            next
          end
  
          province = Province.find_by('province_thai ILIKE ?', "%#{row['จังหวัด']}%")
          province_id = province&.id
          if province_id.nil?
            errors << "ชื่อจังหวัด '#{row['จังหวัด']}' ไม่ถูกต้อง"
            error_patient_count += 1
            next
          end
  
          district = District.find_by('district_thai_short ILIKE ?', "%#{row['อำเภอ']}%")
          district_id = district&.id
          if district_id.nil?
            errors << "ชื่ออำเภอ '#{row['district']}' ไม่ถูกต้อง"
            error_patient_count += 1
            next
          end
  
          sub_district = SubDistrict.find_by('sub_district_thai_short ILIKE ?', "%#{row['ตำบล']}%")
          sub_district_id = sub_district&.id
          if sub_district_id.nil?
            errors << "ชื่อตำบล '#{row['sub_district']}' ไม่ถูกต้อง"
            error_patient_count += 1
            next
          end
  
          health_in_id = nil
          health_in_mapping = {
            'สิทธิข้าราชการ' => 'ข้าราชการ, ต้นสังกัด',
            'สิทธิประกันสังคม' => 'ประกันสังคม',
            'สิทธิรัฐวิสาหกิจ' => 'ข้าราชการ, ต้นสังกัด'
          }
            
          health_in_names = row['HealthIn'].to_s.split('/')
          health_in_names.each do |health_in_name|
            health_in_name.strip!
            next if health_in_name.empty?

            # Map user input to database value if exists
            mapped_health_in_name = health_in_mapping[health_in_name] || health_in_name
  
            health_in = HealthInsurance.find_by("name ILIKE ?", "%#{mapped_health_in_name}%")
            if health_in.nil?
              errors << "ไม่พบสิทธิพิเศษ '#{health_in_name}'"
              next
            else
              health_in_id = health_in.id
            end
          end

          if health_in_id.nil? && health_in_names.any?
            error_patient_count += 1
            next 
          end
  
          mars = MaritalStatus.find_by("name ILIKE ?", "%#{row['MarS']}%")
          mars_id = mars&.id
  
          race = Race.find_by(name: row['Race'])
          race_id = race&.id
          if race_id.nil?
            errors << "ไม่พบสัญชาติ '#{row['Race']} ในฐานข้อมูล'"
            error_patient_count += 1
            next
          end
  
          sex = Sex.find_by(name: row["Sex"])
          sex_id = sex&.id
          if sex_id.nil?
            errors << "ไม่พบเพศ '#{row['Sex']}'"
            error_patient_count += 1
            next
          end
  
          patient = Patient.find_or_initialize_by(hos_no: row['HosNo1'])
          if patient.new_record?
            new_patient_count += 1
          end
  
          patient.assign_attributes(
            name: row['name'],
            age: row['Age'],
            citizen_id: row['Id'],
            sex_id: sex_id,
            race_id: race_id,
            marital_status_id: mars_id,
            id_finding: row['Id'],
            birth_date: row['BirthD'],
            health_insurance_id: health_in_id,
            address_detail: row['AddDet'],
            province_id: province_id,
            address_code_id: add_code_id,
            district_id: district_id,
            sub_district_id: sub_district_id,
            post_code_id: post_code_id
          )
  
          if patient.save
            ActiveRecord::Base.transaction do
              begin

                existing_cancer_form = CancerForm.joins(:cancer_information)
                                       .where(patient_id: patient.id, cancer_informations: { icd_10: row["icd10"] })
                                       .first
                if existing_cancer_form
                  Rails.logger.info "CancerForm with icd_10: #{row['icd10']} already exists for Patient ID: #{patient.id}. Skipping creation of CancerForm."
                  errors << "CancerForm with icd_10: #{row['icd10']} already exists for Patient ID: #{patient.id}. maybe duplicate information"
                  next
                end
                # Create only once for each patient
                cancer_information = CancerInformation.create!(icd_10: row["icd10"])
                Rails.logger.info "Created CancerInformation with id: #{cancer_information.id} and icd_10: #{row['icd10']}"
          
                treatment_follow_up = TreatmentFollowUp.create!
                information_diagnosis = InformationDiagnosis.create!
                treatment_information = TreatmentInformation.create!
          
                cancer_form = CancerForm.create!(
                  patient_id: patient.id,
                  primary: patient.cancer_forms.count + 1,
                  is_editing: false,
                  treatment_follow_up_id: treatment_follow_up.id,
                  information_diagnosis_id: information_diagnosis.id,
                  treatment_information_id: treatment_information.id,
                  cancer_information_id: cancer_information.id,
                  cancer_form_status_id: CancerFormStatus.find(1).id
                )
                Rails.logger.info "Created CancerForm with id: #{cancer_form.id} for Patient ID: #{patient.id}"
                
              rescue => e
                Rails.logger.error "Failed to create CancerForm or related records for Patient ID: #{patient.id} - Error: #{e.message}"
                raise ActiveRecord::Rollback
              end
            end
          else
            errors << "Failed to save patient for row hn #{row['HosNo1']}: #{row["Id"]} - Error: #{patient.errors.full_messages.join(', ')}"
            error_patient_count += 1
          end

        rescue ActiveRecord::RecordInvalid => e
          errors << "Failed to save record for row hn #{row['HosNo1']}: - Error: #{e.message}"
          error_patient_count += 1
        end
      end

      ImportPatient.create!(
        date: Time.now,
        total_patient_count: total_patient_count,
        new_patient_count: new_patient_count,
        existing_patient_count: Patient.all.count,
        error_patient_count: error_patient_count
      )#delayed_job แยกกับตัวอื่น
  
      if errors.any?
         { error: "Data import failed", details: errors }
      else
         { message: "Data imported successfully from uploaded file" }
      end
    else
        { error: "No file uploaded" }
    end
  end

  def self.export_patients(params = {})
    csv_file_path = Rails.root.join('lib', 'csv_files', 'Exported_Patient.csv')
    headers = [
      "Hospital", "HN", "Name", "Sex", "Post", "AddCode", "MarCode", "Race", "Rel", "HealthIn", "Basis", 
      "TopCode", "Latera", "Beh", "Lab", "Stag", "Ext", "Met", "Grad", "CaseType", "Present", "DeathStat", 
      "ReferFr", "ReferTo", "Surg", "Radia", "Chemo", "Target", "Hormone", "Immu", "InterThe", "Nuclear", 
      "StemCell", "BoneScan", "Supp", "NonTreat"
    ]

    start_date = params[:start_date]
    end_date = params[:end_date]

    patients = if start_date.present? && end_date.present?
                Patient.includes(cancer_forms: [:cancer_information, :treatment_follow_up, :treatment_information])
                      .where('cancer_informations.diagnosis_date BETWEEN ? AND ?', start_date, end_date)
                      .references(:cancer_information)
              else
                Patient.includes(cancer_forms: [:cancer_information, :treatment_follow_up, :treatment_information])
              end

    CSV.open(csv_file_path, 'w', write_headers: true, headers: headers) do |csv|
      patients.find_each do |patient|
        patient.cancer_forms.each do |cancer_form|
          csv << [
            patient.hospital&.code || '',
            patient.hos_no || '',
            patient.name || '',
            patient.sex&.code || '',
            patient.post_code&.code || '',
            patient.address_code&.code || '',
            patient.marital_status&.code || '',
            patient.race&.code || '',
            patient.religion&.code || '',
            patient.health_insurance&.code || '',
            cancer_form.cancer_information&.basis&.code || '',
            "\"#{cancer_form.cancer_information&.topography_code&.code || ''}\"",
            cancer_form.cancer_information&.laterality&.code || '',
            cancer_form.cancer_information&.behavior&.code || '',
            cancer_form.cancer_information&.lab&.code || '',
            cancer_form.cancer_information&.stage&.code || '',
            cancer_form.cancer_information&.extent&.code || '',
            cancer_form.cancer_information&.metastasis_site&.code || '',
            cancer_form.cancer_information&.grad&.code || '',
            cancer_form.cancer_information&.case_type&.code || '',
            cancer_form.treatment_follow_up&.present&.code || '',
            cancer_form.treatment_follow_up&.death_stat&.code || '',
            cancer_form.treatment_follow_up&.refer_from&.code || '',
            cancer_form.treatment_follow_up&.refer_to&.code || '',
            patient.boolean_to_integer(cancer_form.treatment_information&.is_surg),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_radia),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_chemo),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_target),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_hormone),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_immu),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_inter_the),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_nuclear),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_stem_cell),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_bone_scan),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_supportive),
            patient.boolean_to_integer(cancer_form.treatment_information&.is_treatment)
          ]
        end
      end
    end

    csv_file_path
  end

  def boolean_to_integer(value)
    value.nil? ? nil : (value ? 1 : 2)
  end

end

