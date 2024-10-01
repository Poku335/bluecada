class ImportDiagParagraphJob < ApplicationJob
  queue_as :default

  def perform(input_file, output_file)
    format_csv(input_file, output_file)

    errors = []
    CSV.foreach(output_file, headers: true, encoding: 'bom|utf-8') do |row|
      begin
        reqdate = Date.strptime(row['REQDATE'], '%m/%d/%y').strftime('%Y-%m-%d')
      rescue ArgumentError
        reqdate = nil
      
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
          diag_date: reqdate
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
end