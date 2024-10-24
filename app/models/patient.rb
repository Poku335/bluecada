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
  has_many :cancer_forms, dependent: :destroy
  after_create :save_post_code_and_address_code

  validates :hos_no, uniqueness: true
  validates :citizen_id, uniqueness: true

  def as_json(options = {})
    diagnosis_age = 
    if cancer_forms.first&.cancer_information&.diagnosis_date.present? && self.birth_date.present?
      diagnosis_date = cancer_forms.first.cancer_information.diagnosis_date
      ((diagnosis_date - birth_date) / 365.25).to_i
    else
      nil
    end

    super(options.merge(except: [:hospital_id, :sex_id, :post_code_id, :address_code_id, :marital_status_id, :race_id, :religion_id, :health_insurance_id, :province_id, :district_id, :sub_district_id])).merge(
      hospital: hospital,
      sex: sex,
      diagnosis_age: diagnosis_age,
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
    end_date = params[:end_date]
    
    if params[:preview]
      data = all

      data = data.select %(
        patients.id,
        cancer_forms.id AS cancer_form_id,
        cancer_forms.tumor_id AS cancer_form_tumor_id,
        patients.hos_no AS patient_hn,
        patients.name AS patient_name,
        hospitals.code AS hospital_code,
        sexes.code AS sex_code,
        post_codes.code AS post_code,
        address_codes.code AS address_code,
        marital_statuses.code AS marital_status_code,
        races.code AS race_code,
        religions.code AS religion_code,
        health_insurances.code AS health_insurance_code,
        bases.code AS basis_code,
        topography_codes.code AS top_code,
        lateralities.code AS latera_code,
        behaviors.code AS beh_code,
        labs.code AS lab_code,
        stages.code AS stage_code,
        extents.code AS extent_code,
        metastasis_sites.code AS met_code,
        grads.code AS grad_code,
        case_types.code AS case_type_code,
        presents.code AS present_code,
        death_stats.code AS death_stat_code,
        refer_from_hospitals.code AS refer_from_code,
        refer_to_hospitals.code AS refer_to_code,
        topography_codes.icd_10 AS topography_code,
        icdos.icdo_32_c AS morphology_code,
        CASE WHEN treatment_informations.is_radia IS TRUE THEN 1 WHEN treatment_informations.is_radia IS FALSE THEN 2 ELSE NULL END AS is_radia,
        CASE WHEN treatment_informations.is_chemo IS TRUE THEN 1 WHEN treatment_informations.is_chemo IS FALSE THEN 2 ELSE NULL END AS is_chemo,
        CASE WHEN treatment_informations.is_target IS TRUE THEN 1 WHEN treatment_informations.is_target IS FALSE THEN 2 ELSE NULL END AS is_target,
        CASE WHEN treatment_informations.is_hormone IS TRUE THEN 1 WHEN treatment_informations.is_hormone IS FALSE THEN 2 ELSE NULL END AS is_hormone,
        CASE WHEN treatment_informations.is_immu IS TRUE THEN 1 WHEN treatment_informations.is_immu IS FALSE THEN 2 ELSE NULL END AS is_immu,
        CASE WHEN treatment_informations.is_inter_the IS TRUE THEN 1 WHEN treatment_informations.is_inter_the IS FALSE THEN 2 ELSE NULL END AS is_inter_the,
        CASE WHEN treatment_informations.is_nuclear IS TRUE THEN 1 WHEN treatment_informations.is_nuclear IS FALSE THEN 2 ELSE NULL END AS is_nuclear,
        CASE WHEN treatment_informations.is_stem_cell IS TRUE THEN 1 WHEN treatment_informations.is_stem_cell IS FALSE THEN 2 ELSE NULL END AS is_stem_cell,
        CASE WHEN treatment_informations.is_bone_scan IS TRUE THEN 1 WHEN treatment_informations.is_bone_scan IS FALSE THEN 2 ELSE NULL END AS is_bone_scan,
        CASE WHEN treatment_informations.is_supportive IS TRUE THEN 1 WHEN treatment_informations.is_supportive IS FALSE THEN 2 ELSE NULL END AS is_supportive,
        CASE WHEN treatment_informations.is_treatment IS TRUE THEN 1 WHEN treatment_informations.is_treatment IS FALSE THEN 2 ELSE NULL END AS is_treatment
      )

      data = data.joins("LEFT JOIN (
          SELECT *,
            ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY created_at ASC) AS rn
          FROM cancer_forms
        ) AS cancer_forms ON cancer_forms.patient_id = patients.id AND cancer_forms.rn = 1"
      )

      data = data.joins('LEFT JOIN cancer_informations ON cancer_forms.cancer_information_id = cancer_informations.id')
                 .joins('LEFT JOIN bases ON cancer_informations.basis_id = bases.id')
                 .joins('LEFT JOIN topography_codes ON cancer_informations.topography_code_id = topography_codes.id')
                 .joins('LEFT JOIN lateralities ON cancer_informations.laterality_id = lateralities.id')
                 .joins('LEFT JOIN behaviors ON cancer_informations.behavior_id = behaviors.id')
                 .joins('LEFT JOIN labs ON cancer_informations.lab_id = labs.id')
                 .joins('LEFT JOIN stages ON cancer_informations.stage_id = stages.id')
                 .joins('LEFT JOIN extents ON cancer_informations.extent_id = extents.id')
                 .joins('LEFT JOIN metastasis_sites ON cancer_informations.metastasis_site_id = metastasis_sites.id')
                 .joins('LEFT JOIN grads ON cancer_informations.grad_id = grads.id')
                 .joins('LEFT JOIN treatment_follow_ups ON cancer_forms.treatment_follow_up_id = treatment_follow_ups.id')
                 .joins('LEFT JOIN treatment_informations ON cancer_forms.treatment_information_id = treatment_informations.id')
                 .joins('LEFT JOIN hospitals ON patients.hospital_id = hospitals.id')
                 .joins('LEFT JOIN sexes ON patients.sex_id = sexes.id')
                 .joins('LEFT JOIN post_codes ON patients.post_code_id = post_codes.id')
                 .joins('LEFT JOIN address_codes ON patients.address_code_id = address_codes.id')
                 .joins('LEFT JOIN marital_statuses ON patients.marital_status_id = marital_statuses.id')
                 .joins('LEFT JOIN races ON patients.race_id = races.id')
                 .joins('LEFT JOIN religions ON patients.religion_id = religions.id')
                 .joins('LEFT JOIN health_insurances ON patients.health_insurance_id = health_insurances.id')
                 .joins('LEFT JOIN case_types ON cancer_informations.case_type_id = case_types.id')
                 .joins('LEFT JOIN presents ON treatment_follow_ups.present_id = presents.id')
                 .joins('LEFT JOIN death_stats ON treatment_follow_ups.death_stat_id = death_stats.id')
                 .joins('LEFT JOIN hospitals AS refer_from_hospitals ON treatment_follow_ups.refer_from_id = refer_from_hospitals.id')
                 .joins('LEFT JOIN hospitals AS refer_to_hospitals ON treatment_follow_ups.refer_to_id = refer_to_hospitals.id')
                 .joins('LEFT JOIN topography_codes ON cancer_informations.topography_code_id = topography_codes.id')
                 .joins('LEFT JOIN icdos ON cancer_informations.icdo_id = icdos.id')
                
      if start_date.present? && end_date.present?
        data = data.where('cancer_informations.diagnosis_date BETWEEN ? AND ?', start_date, end_date)
      end

      data = data.where("case_types.id = #{params[:case_type_id]}") if params[:case_type_id].present?
      
      params[:order] = "patients.#{params[:order]}" if params[:order].present?
      data = super(params.merge!(data: data))
    else
      data = all

      data = data.select %(
        patients.*,
        cancer_forms.id AS cancer_form_id,
        cancer_forms.tumor_id AS cancer_form_tumor_id,
        cancer_forms.primary AS cancer_form_primary,
        cancer_forms.cancer_form_status_id AS cancer_form_status, 
        cancer_form_statuses.name AS cancer_form_status_name,
        cancer_informations.icd_10 AS icd_10,
        case_types.name AS case_type_name,
        users.first_name AS current_user_name,
        races.name AS race_name,
        hospitals.name AS hospital_name,
        sexes.name AS sex_name,
        post_codes.code AS post_code,
        topography_codes.icd_10 AS topography_code,
        icdos.icdo_32_c AS morphology_code,
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
      data = data.joins("LEFT JOIN (
          SELECT *,
            ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY created_at ASC) AS rn
          FROM cancer_forms
        ) AS cancer_forms ON cancer_forms.patient_id = patients.id AND cancer_forms.rn = 1"
      )

      data = data.joins('LEFT JOIN cancer_form_statuses ON cancer_forms.cancer_form_status_id = cancer_form_statuses.id')
                 .joins('LEFT JOIN users ON users.id = cancer_forms.current_user_id')
                 .joins('LEFT JOIN cancer_informations ON cancer_forms.cancer_information_id = cancer_informations.id')
                 .joins('LEFT JOIN case_types ON cancer_informations.case_type_id = case_types.id')
                 .joins('LEFT JOIN topography_codes ON cancer_informations.topography_code_id = topography_codes.id')
                 .joins('LEFT JOIN icdos ON cancer_informations.icdo_id = icdos.id')
      params[:keywords_columns] = ["patients.name", "patients.hos_no", :citizen_id, :id_finding]
      params[:order] = params[:order] || "patients.id"

      data = data.where("case_types.id = #{params[:case_type_id]}") if params[:case_type_id].present?
      data = super(params.merge!(data: data))
    end
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
            errors << "#{row['name']}: Address Code '#{row['AddCode']}' ไม่ถูกต้อง"
            error_patient_count += 1
            next
          end
  
          post_code = PostCode.find_by(code: row['Post'])
          post_code_id = post_code&.id
          if post_code_id.nil?
            errors << "#{row['name']}: รหัสไปรษณีย์ '#{row['Post']}' ไม่ถูกต้อง"
            error_patient_count += 1
            next
          end
  
          province = Province.find_by('province_thai ILIKE ?', "%#{row['จังหวัด']}%")
          province_id = province&.id
          if province_id.nil?
            errors << "#{row['name']}: ชื่อจังหวัด '#{row['จังหวัด']}' ไม่ถูกต้อง"
            error_patient_count += 1
            next
          end
  
          district = District.find_by('district_thai_short ILIKE ?', "%#{row['อำเภอ']}%")
          district_id = district&.id
          if district_id.nil?
            errors << "#{row['name']}: ชื่ออำเภอ '#{row['district']}' ไม่ถูกต้อง"
            error_patient_count += 1
            next
          end
  
          sub_district = SubDistrict.find_by('sub_district_thai_short ILIKE ?', "%#{row['ตำบล']}%")
          sub_district_id = sub_district&.id
          if sub_district_id.nil?
            errors << "#{row['name']}: ชื่อตำบล '#{row['sub_district']}' ไม่ถูกต้อง"
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

            mapped_health_in_name = health_in_mapping[health_in_name] || health_in_name
  
            health_in = HealthInsurance.find_by("name ILIKE ?", "%#{mapped_health_in_name}%")
            if health_in.nil?
              errors << "#{row['name']}: ไม่พบสิทธิพิเศษ '#{health_in_name}'"
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
            errors << "#{row['name']}: ไม่พบสัญชาติ '#{row['Race']} ในฐานข้อมูล'"
            error_patient_count += 1
            next
          end
  
          sex = Sex.find_by(name: row["Sex"])
          sex_id = sex&.id
          if sex_id.nil?
            errors << "#{row['name']}: ไม่พบเพศ '#{row['Sex']}'"
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
                  errors << "#{row['name']}: CancerForm with icd_10: #{row['icd10']} already exists for Patient ID: #{patient.id}. maybe duplicate information"
                  next
                end
                
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
            errors << "#{row['name']}: Failed to save patient for row hn #{row['HosNo1']}: #{row["Id"]} - Error: #{patient.errors.full_messages.join(', ')}"
            error_patient_count += 1
          end
  
        rescue ActiveRecord::RecordInvalid => e
          errors << "#{row['name']}: Failed to save record for row hn #{row['HosNo1']}: - Error: #{e.message}"
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
    case_type_id = params[:case_type_id] if params[:case_type_id].present?
    start_date = params[:start_date]
    end_date = params[:end_date]
    
    patients =  if start_date.present? && end_date.present?
                  Patient.joins(cancer_forms: :cancer_information)
                          .includes(cancer_forms: [:treatment_follow_up, :treatment_information])
                          .where('cancer_informations.diagnosis_date BETWEEN ? AND ?', start_date, end_date)
                          .where('cancer_informations.case_type_id = ?', case_type_id) if case_type_id.present?
                else
                  Patient.joins(cancer_forms: :cancer_information)
                          .includes(cancer_forms: [:treatment_follow_up, :treatment_information])
                          .where('cancer_informations.case_type_id = ?', case_type_id) if case_type_id.present?
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

  def self.preview_patients(params = {})
    start_date = params[:start_date]
    end_date = params[:end_date]

    patients = if start_date.present? && end_date.present?
                Patient.includes(cancer_forms: [:cancer_information, :treatment_follow_up, :treatment_information])
                      .where('cancer_informations.diagnosis_date BETWEEN ? AND ?', start_date, end_date)
                      .references(:cancer_information)
              else
                Patient.includes(cancer_forms: [:cancer_information, :treatment_follow_up, :treatment_information])
              end

    preview_data = []

    patients.find_each do |patient|
      patient.cancer_forms.each do |cancer_form|
        preview_data << {
          id: cancer_form.id,
          hospital: patient.hospital&.code || '',
          hn: patient.hos_no || '',
          name: patient.name || '',
          sex: patient.sex&.code || '',
          post: patient.post_code&.code || '',
          add_code: patient.address_code&.code || '',
          mar_code: patient.marital_status&.code || '',
          race: patient.race&.code || '',
          rel: patient.religion&.code || '',
          health_in: patient.health_insurance&.code || '',
          basis: cancer_form.cancer_information&.basis&.code || '',
          top_code: cancer_form.cancer_information&.topography_code&.code || '',
          latera: cancer_form.cancer_information&.laterality&.code || '',
          beh: cancer_form.cancer_information&.behavior&.code || '',
          lab: cancer_form.cancer_information&.lab&.code || '',
          stag: cancer_form.cancer_information&.stage&.code || '',
          ext: cancer_form.cancer_information&.extent&.code || '',
          met: cancer_form.cancer_information&.metastasis_site&.code || '',
          grad: cancer_form.cancer_information&.grad&.code || '',
          case_type: cancer_form.cancer_information&.case_type&.code || '',
          present: cancer_form.treatment_follow_up&.present&.code || '',
          death_stat: cancer_form.treatment_follow_up&.death_stat&.code || '',
          refer_fr: cancer_form.treatment_follow_up&.refer_from&.code || '',
          refer_to: cancer_form.treatment_follow_up&.refer_to&.code || '',
          is_surg: patient.boolean_to_integer(cancer_form.treatment_information&.is_surg),
          is_radia: patient.boolean_to_integer(cancer_form.treatment_information&.is_radia),
          is_chemo: patient.boolean_to_integer(cancer_form.treatment_information&.is_chemo),
          is_target: patient.boolean_to_integer(cancer_form.treatment_information&.is_target),
          is_hormone: patient.boolean_to_integer(cancer_form.treatment_information&.is_hormone),
          is_immu: patient.boolean_to_integer(cancer_form.treatment_information&.is_immu),
          is_inter_the: patient.boolean_to_integer(cancer_form.treatment_information&.is_inter_the),
          is_nuclear: patient.boolean_to_integer(cancer_form.treatment_information&.is_nuclear),
          is_stem_cell: patient.boolean_to_integer(cancer_form.treatment_information&.is_stem_cell),
          is_bone_scan: patient.boolean_to_integer(cancer_form.treatment_information&.is_bone_scan),
          is_supportive: patient.boolean_to_integer(cancer_form.treatment_information&.is_supportive),
          is_treatment: patient.boolean_to_integer(cancer_form.treatment_information&.is_treatment)
        }
        end
      end
      preview_data
  end

end

