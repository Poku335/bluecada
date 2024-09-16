class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate!
  skip_before_action :authenticate! , only: [:login]
  require 'csv'
  

  # def export
  #   csv_file_path = Rails.root.join('lib', 'csv_files', 'Exported_Patient.csv')
  
  #   CSV.open(csv_file_path, 'w', write_headers: true, headers: ["TumerID", "HN", "Name", "ID", "Sex"]) do |csv|
  #     Patient.find_each do |patient|
  #       tumerID = Patient.find_by(id: patient.)
  #       farmer_information = farmer.farmer_information || {}
  #       age = farmer_information["age"] || "N/A"  
  #       csv << [forms_data.id, forms_data.year, forms_data.round, farmer_information, forms_data.farmer_id]
  #     end
  #   end
  
  #   send_file csv_file_path, type: 'text/csv', disposition: 'attachment', filename: 'Exported_forms_datas.csv'
  # end

  # def preprocess_csv(input_file, output_file)
  #   File.open(output_file, "w", encoding: 'utf-8') do |out_file|
  #     buffer = ""
  #     in_quotes = false
  #     quote_count = 0
      
  #     File.foreach(input_file, encoding: 'bom|utf-8').with_index(1) do |line, line_number|
  #       puts "Processing line #{line_number}"
  #       line.each_char do |char|
  #         if char == '"'
  #           quote_count += 1
  #           in_quotes = (quote_count % 2 != 0)
  #         end
          
  #         if char == "\n" && !in_quotes
  #           # End of a valid row
  #           cleaned_line = buffer.gsub(/"/, '""').strip
  #           begin
  #             fields = cleaned_line.split(/,(?=(?:[^"]*"[^"]*")*[^"]*$)/)
  #             if fields && !fields.empty?
  #               quoted_fields = fields.map { |field| %Q("#{field.strip.gsub(/"/, '""')}") }
  #               out_file.puts quoted_fields.join(',')
  #             else
  #               puts "Warning: Empty or invalid line at #{line_number}"
  #             end
  #           rescue => e
  #             puts "Error parsing line #{line_number}: #{e.message}"
  #           end
  #           buffer = ""
  #           quote_count = 0
  #         else
  #           buffer << char
  #         end
  #       end
  #     end
      
  #     # Process any remaining buffer
  #     unless buffer.empty?
  #       cleaned_line = buffer.gsub(/"/, '""').strip
  #       begin
  #         fields = cleaned_line.split(/,(?=(?:[^"]*"[^"]*")*[^"]*$)/)
  #         if fields && !fields.empty?
  #           quoted_fields = fields.map { |field| %Q("#{field.strip.gsub(/"/, '""')}") }
  #           out_file.puts quoted_fields.join(',')
  #         else
  #           puts "Warning: Empty or invalid last line"
  #         end
  #       rescue => e
  #         render json: {error: "Error parsing last line: #{e.message}"}
  #       end
  #     end
  #   end
  # end

  
  
  def format_csv(input_file, output_file)
    CSV.open(output_file, 'w', write_headers: false, force_quotes: true) do |csv_out|
      CSV.foreach(input_file, headers: false) do |row|
        formatted_row = row.map do |field|
          # แทนที่ newline ด้วย space ในแต่ละฟิลด์
          field.nil? ? '' : field.gsub(/\r\n|\n/, ' ').strip
        end
        csv_out << formatted_row
      end
    end
    puts "Finished processing CSV"
  end

  def import_diag_paragraph
    input_file = params[:file].path
    output_file = "#{Rails.root}/tmp/preprocessed_#{File.basename(input_file)}"
    if params[:file].present?
      # ฟอร์แมต CSV ก่อนการนำเข้า
      begin
        format_csv(input_file, output_file)
      rescue => e
        render json: { error: "Error preprocessing CSV file: #{e.message}" }, status: :unprocessable_entity
        return
      end
      
      errors = []
      CSV.foreach(output_file, headers: true, encoding: 'bom|utf-8') do |row|
        begin
          hn = row['HN_N']
          patient = Patient.find_by(hos_no: hn)
          if patient.nil?
            errors << "ไม่พบผู้ป่วยที่มี HN: #{hn}"
            next
          end
  
          cancer_form = CancerForm.find_by(patient_id: patient.id)
          if cancer_form.nil?
            errors << "ไม่พบข้อมูล CancerForm สำหรับผู้ป่วยที่มี HN: #{hn}"
            next
          end
  
          diag_para = DiagnoseParagraph.create!(
            cancer_information_id: cancer_form.cancer_information_id,
            diagnose_paragraph: row['DIAGNOSIS'],
            diag_date: row['REQDATE']
          )
  
          icdo_results = []
          keyword_counts = {}
          results = {}
  
          if row['DIAGNOSIS'].present?
            keywords = row['DIAGNOSIS'].scan(/\b\w+\b/).map(&:downcase)
            keywords.each do |keyword|
              original_keyword = keyword.strip
              next if %w[differentiation u s g pap low cyst os p disease situ 21 like d i n c side m re b or invasive cap neu per small ca 3a system form forms ni an be polyp acute mixed 22 non diffuse mid man nodule moderate round 14 stroma black type 16 features showing nodular pe show gh on marked tan ia node tissue olig negative red feature clear fibrous gland gene benign site nest margin 6 from deep lesion iii ii v 12 9 17 8 va lymph 4 border 5 x no not differentiated single 3 all between a for at well pr 11 r of 2 1 er ki e t h and with as test cell o her in cut the grade high 19 chronic positive 15 is multiple].include?(original_keyword.downcase)
  
              search_results = Icdo.search_by_paragraph(keyword)
              results_count = search_results.count
  
              keyword_counts[keyword] = results_count if results_count > 0
              if results_count < 25
                search_results.each do |result|
                  icdo_results << result unless icdo_results.include?(result)
                  results[keyword] = results_count if results_count > 0
                end
              end
            end
  
            combined_keywords = keywords.select { |kw| keyword_counts[kw] && keyword_counts[kw] > 25 }
            if combined_keywords.any?
              combined_keywords.each_slice(3) do |keyword_group|
                combined_keyword_string = keyword_group.join(' ')
                unique_combined_keywords = combined_keyword_string.split.uniq.join(' ')
                combined_results = Icdo.search_by_paragraph(unique_combined_keywords)
                combined_results_count = combined_results.count
  
                if combined_results_count <= 25
                  combined_results.each do |result|
                    icdo_results << result unless icdo_results.include?(result)
                    results[unique_combined_keywords] = combined_results_count if combined_results_count > 0
                  end
                end
              end
            end
          end
  
          if icdo_results.empty?
            # สร้าง SearchIcdo เปล่าๆ ถ้าไม่มี icdo_results
            SearchIcdo.create!(
              diagnose_paragraph_id: diag_para.id,
              icdo_id: nil
            )
          else
            icdo_results.each do |icdo_result|
              SearchIcdo.create!(
                diagnose_paragraph_id: diag_para.id,
                icdo_id: icdo_result.id
              )
            end
          end
  
        rescue CSV::MalformedCSVError => e
          errors << "Failed to save record for HN: #{hn} - Error: #{e.message}"
          next # Skip the malformed line
        rescue ActiveRecord::RecordInvalid => e
          errors << "Failed to save record for HN: #{hn} - Error: #{e.message}"
        rescue => e
          errors << "An unexpected error occurred for HN: #{hn} - Error: #{e.message}"
        end
      end
  
      if errors.any?
        render json: { error: "Data import failed", details: errors }
      else
        render json: { message: "Data imported successfully from uploaded file"}
      end
    else
      render json: { error: "No file uploaded" }, status: :unprocessable_entity
    end
  end

  def import_patient
      if params[:file].present?
        file = params[:file]
        csv_file_path = file.path
        errors = []
        CSV.foreach(csv_file_path, headers: true, encoding: 'bom|utf-8') do |row|
          begin
            add_code = AddressCode.find_by(code: row['AddCode'])
            add_code_id = add_code&.id
            if add_code_id.nil?
              errors << "Address Code '#{row['AddCode']}' ไม่ถูกต้อง"
              next
            end

            post_code = PostCode.find_by(code: row['Post'])
            post_code_id = post_code&.id
            if post_code_id.nil?
              errors << "รหัสไปรษณีย์ '#{row['Post']}' ไม่ถูกต้อง"
              next
            end
  
            province = Province.find_by('province_thai ILIKE ?', "%#{row['จังหวัด']}%")
            province_id = province&.id
            if province_id.nil?
              errors << "ชื่อจังหวัด '#{row['จังหวัด']}' ไม่ถูกต้อง"
              next
            end
  
            district = District.find_by('district_thai_short ILIKE ?', "%#{row['อำเภอ']}%")
            district_id = district&.id
            if district_id.nil?
              errors << "ชื่ออำเภอ '#{row['district']}' ไม่ถูกต้อง"
              next
            end
  
            sub_district = SubDistrict.find_by('sub_district_thai_short ILIKE ?', "%#{row['ตำบล']}%")
            sub_district_id = sub_district&.id
            if sub_district_id.nil?
              errors << "ชื่อตำบล '#{row['sub_district']}' ไม่ถูกต้อง"
              next
            end
  
            health_in_id = nil

            health_in_names = row['HealthIn'].to_s.split('/')
            health_in_names.each do |health_in_name|
              health_in_name.strip!
              next if health_in_name.empty?

              health_in = HealthInsurance.find_by("name ILIKE ?", "%#{health_in_name}%")
              if health_in.nil?
                errors << "ไม่พบสิทธิพิเศษ '#{health_in_name}'"
                next
              else
                health_in_id = health_in.id
              end
            end

            if health_in_id.nil? && health_in_names.any?
              next # Skip this row if none of the health insurance names were found
            end
  
            mars = MaritalStatus.find_by("name ILIKE ?", "%#{row['MarS']}%")
            mars_id = mars&.id
  
            race = Race.find_by(name: row['Race'])
            race_id = race&.id
            if race_id.nil?
              errors << "ไม่พบสัญชาติ '#{row['Race']} ในฐานข้อมูล'"
              next
            end
  
            sex = Sex.find_by(name: row["Sex"])
            sex_id = sex&.id
            if sex_id.nil?
              errors << "ไม่พบเพศ '#{row['Sex']}'"
              next
            end
  
            # tel = row['tel']
            # if tel.blank? || tel.length != 11
            #   errors << "หมายเลขโทรศัพท์ '#{tel}' ต้องมีความยาว 11 ตัว"
            #   next
            # end
  
            patient = Patient.find_or_create_by(hos_no: row['HosNo1']) do |f|
              f.name = row['name']
              f.age = row['Age']
              f.sex_id = sex_id
              f.race_id = race_id
              f.marital_status_id = mars_id
              f.id_finding = row['Id']
              f.birth_date = row['BirthD']
              f.health_insurance_id = health_in_id
              f.address_detail = row['AddDet']
              f.province_id = province_id
              f.address_code_id = add_code_id
              f.district_id = district_id
              f.sub_district_id = sub_district_id
              f.post_code_id = post_code_id
            end

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

  
          rescue ActiveRecord::RecordInvalid => e
            errors << "Failed to save record for row: #{row.inspect} - Error: #{e.message}"
          end
        end
  
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
          @current_user = User.find_by(id: decoded[:user_id])
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
