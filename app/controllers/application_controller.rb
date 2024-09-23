class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate!
  skip_before_action :authenticate! , only: [:login]
  require 'csv'
  include ExceptionHandler

  def export_patients
    csv_file_path = Rails.root.join('lib', 'csv_files', 'Exported_Patient.csv')
    headers = [
      "Hospital", "HN", "Name", "Sex", "Post", "AddCode", "MarCode", "Race", "Rel", "HealthIn", "Basis", 
      "TopCode", "Latera", "Beh", "Lab", "Stag", "Ext", "Met", "Grad", "CaseType", "Present", "DeathStat", 
      "ReferFr", "ReferTo", "Surg", "Radia", "Chemo", "Target", "Hormone", "Immu", "InterThe", "Nuclear", 
      "StemCell", "BoneScan", "Supp", "NonTreat"]
      CSV.open(csv_file_path, 'w', write_headers: true, headers: headers) do |csv|
        Patient.includes(cancer_forms: [:cancer_information, :treatment_follow_up, :treatment_information]).find_each do |patient|
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
          cancer_form.treatment_information&.is_surg.nil? ? nil : (cancer_form.treatment_information&.is_surg ? 1 : 2),
          cancer_form.treatment_information&.is_radia.nil? ? nil : (cancer_form.treatment_information&.is_radia ? 1 : 2),
          cancer_form.treatment_information&.is_chemo.nil? ? nil : (cancer_form.treatment_information&.is_chemo ? 1 : 2),
          cancer_form.treatment_information&.is_target.nil? ? nil : (cancer_form.treatment_information&.is_target ? 1 : 2),
          cancer_form.treatment_information&.is_hormone.nil? ? nil : (cancer_form.treatment_information&.is_hormone ? 1 : 2),
          cancer_form.treatment_information&.is_immu.nil? ? nil : (cancer_form.treatment_information&.is_immu ? 1 : 2),
          cancer_form.treatment_information&.is_inter_the.nil? ? nil : (cancer_form.treatment_information&.is_inter_the ? 1 : 2),
          cancer_form.treatment_information&.is_nuclear.nil? ? nil : (cancer_form.treatment_information&.is_nuclear ? 1 : 2),
          cancer_form.treatment_information&.is_stem_cell.nil? ? nil : (cancer_form.treatment_information&.is_stem_cell ? 1 : 2),
          cancer_form.treatment_information&.is_bone_scan.nil? ? nil : (cancer_form.treatment_information&.is_bone_scan ? 1 : 2),
          cancer_form.treatment_information&.is_supportive.nil? ? nil : (cancer_form.treatment_information&.is_supportive ? 1 : 2),
          cancer_form.treatment_information&.is_treatment.nil? ? nil : (cancer_form.treatment_information&.is_treatment ? 1 : 2)
        ]
          end
        end
      end
  
    send_file csv_file_path, type: 'text/csv', disposition: 'attachment', filename: 'Exported_patient_datas.csv'
  end

  def import_diag_paragraph
    if params[:file].present?
      input_file = params[:file].path
      output_file = "#{Rails.root}/tmp/preprocessed_#{File.basename(input_file)}"
      
      # คัดลอกไฟล์ไปยังตำแหน่งที่ปลอดภัย
      safe_input_file = "#{Rails.root}/tmp/#{File.basename(input_file)}"
      FileUtils.cp(input_file, safe_input_file)
      
      # เรียกใช้ job ใน background
      ImportDiagParagraphJob.perform_later(safe_input_file, output_file)
      
      render json: { message: "Data import started. You will be notified once it's completed." }
    else
      render json: { error: "No file uploaded" }, status: :unprocessable_entity
    end
  end

  def import_patient
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
            'สิทธิข้าราชการ' => 'ข้าราชการ, ต้นสังกัด'
          } # Add more mappings here
  
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
            next # Skip this row if none of the health insurance names were found
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
            CancerForm.create!(
              patient_id: patient.id,
              primary: patient.cancer_forms.count + 1,
              is_editing: false,
              treatment_follow_up_id: TreatmentFollowUp.create!.id,
              information_diagnosis_id: InformationDiagnosis.create!.id,
              treatment_information_id: TreatmentInformation.create!.id,
              cancer_information_id: CancerInformation.create!(icd_10: row["icd10"]).id,
              cancer_form_status_id: CancerFormStatus.find(1).id
            )
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
      )
  
      if errors.any?
        render json: { error: "Data import failed", details: errors }
      else
        render json: { message: "Data imported successfully from uploaded file" }
      end
    else
      render json: { error: "No file uploaded" }, status: :unprocessable_entity
    end
  end

  def login
      user = User.find_by(user_name: params[:user_name])
      if user && user.authenticate(params[:password])
        token = JsonWebToken.encode({ user_id: user.id })
        render json: { user_id: user.id ,token: token, message: "Login successfully" }, status: :ok
      else
        render json: { error: "Username or password incorrect" }, status: :unauthorized
      end
  end

  def authenticate!
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      begin
        decoded = JsonWebToken.decode(token)
        if decoded[:user_id]
          cache_key = "user_#{decoded[:user_id]}"
          @current_user = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
            User.find_by(id: decoded[:user_id])
          end
        end
      rescue JWT::ExpiredSignature, JWT::DecodeError => e
        render json: { error: e.message }, status: :unauthorized
        return
      end
    end

    unless @current_user
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  private

  def expired_signature(error)
    render json: { error: error.message }, status: :unauthorized
  end

  def decode_error(error)
    render json: { error: error.message }, status: :bad_request
  end
end
