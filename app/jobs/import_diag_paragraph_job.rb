class ImportDiagParagraphJob < ApplicationJob
  queue_as :default

  def perform(input_file, output_file)
    format_csv(input_file, output_file)

    errors = []
    CSV.foreach(output_file, headers: true, encoding: 'bom|utf-8') do |row|

      reqdate = check_year(row['REQDATE'])
      vali_date = check_year(row['VALIDATE'])
      received_date = check_year(row['RECEIVED DATE'])

      hn = row['HN_N']
      patient = Patient.find_by(hos_no: hn) || nil
      cancer_form = CancerForm.find_by(patient_id: patient.id) if patient.present? || nil

      begin

        if cancer_form.nil?
          diag_para = DiagnoseParagraph.create(
            hos_no: hn,
            diagnose_paragraph: row['DIAGNOSIS'],
            diag_date: reqdate,
            vali_date: vali_date,
            received_date: received_date
          )
        else
          diag_para = DiagnoseParagraph.create!(
            hos_no: hn,
            cancer_information_id: cancer_form.cancer_information_id,
            diagnose_paragraph: row['DIAGNOSIS'],
            diag_date: reqdate,
            vali_date: vali_date,
            received_date: received_date
          )
        end

        # ใช้ฟังก์ชัน search_terms เพื่อค้นหา Icdo objects ที่ตรงกับคำใน DIAGNOSIS
        icdo_results = self.class.search_terms(paragraph: row['DIAGNOSIS'])

        if icdo_results.empty?
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
        next 
      rescue ActiveRecord::RecordInvalid => e
        errors << "Failed to save record for HN: #{hn} - Error: #{e.message}"
      rescue => e
        errors << "An unexpected error occurred for HN: #{hn} - Error: #{e.message}"
      end
    end

    if errors.any?
      Rails.logger.error("Data import failed: #{errors.join(', ')}")
    else
      Rails.logger.info("Data imported successfully from uploaded file")
    end
  end

  private

  def self.search_terms(params)
    paragraph = params[:paragraph] # รับค่า paragraph
    terms = Icdo.pluck(:term_used) # ดึงคำทั้งหมดจากคอลัมน์ term_used

    matching_terms = terms.select do |term|
      if paragraph.downcase.include?(term.downcase)
        puts "Found matching term: #{term}" # แสดงคำที่ตรงกัน
        true
      else
        false
      end
    end

    puts "Matching Terms: #{matching_terms.inspect}" # แสดงผลลัพธ์ทั้งหมด

    # ดึง object ของ Icdo ที่ตรงกับคำที่ค้นหาเจอ
    matching_icdo_objects = Icdo.where(term_used: matching_terms)

    matching_icdo_objects
  end

  def format_csv(input_file, output_file)
    CSV.open(output_file, 'w', write_headers: false, force_quotes: true) do |csv_out|
      CSV.foreach(input_file, headers: false) do |row|
        formatted_row = row.map do |field|
          field.nil? ? '' : field.gsub(/\r\n|\n/, ' ').strip
        end
        csv_out << formatted_row
      end
    end
    puts "Finished processing CSV"
  end

  def check_year(get_date)
    begin
      original_date = Date.strptime(get_date, '%m/%d/%y')
    rescue ArgumentError
      return nil
    end
  
    if original_date
      day = original_date.day
      month = original_date.month
      thai_year = original_date.year
      year_now = Time.now.year
  
      if thai_year > year_now
        use_date = Date.strptime("#{day}/#{month}/#{thai_year - 543}", '%d/%m/%Y').strftime('%Y-%m-%d')
      else
        use_date = original_date.strftime('%Y-%m-%d')
      end
    else
      use_date = nil
    end
    use_date
  end  

end