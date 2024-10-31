class Icdo < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_paragraph, against: :term_used, using: {
    tsearch: { prefix: true }
  }
  
  def match_icdo_codes(paragraph)
    Icdo.search_by_term_used(paragraph)
  end

  def self.search_icdo_codes(params = {})
    icdo_results = []
    keyword_counts = {}  
    results = {}  
    
    if params[:paragraph].present?
 
      keywords = params[:paragraph].scan(/\b\w+\b/).map(&:downcase)
      keywords.each do |keyword|
        original_keyword = keyword.strip
    
        next if %w[differentiation u s g pap low cyst os p disease situ 21 like d i n c side m re b or invasive cap neu per small ca 3a system form forms ni an be polyp acute mixed 22 non diffuse mid man nodule moderate round 14 stroma black type 16 features showing nodular pe show gh on marked tan ia node tissue olig negative red feature clear fibrous gland gene benign site nest margin 6 from deep lesion iii ii v 12 9 17 8 va lymph 4 border 5 x no not differentiated single 3 all between a for at well pr 11 r of 2 1 er ki e t h and with as test cell o her in cut the grade high 19 chronic positive 15 is multiple].include?(original_keyword.downcase)

        search_results = Icdo.search_by_paragraph(keyword)
        results_count = search_results.count
        keyword_counts[keyword] = results_count if results_count > 0
        puts "results count for '#{keyword}': #{results_count}"
  
        if results_count < 25
          search_results.each do |result|
            icdo_results << result unless icdo_results.include?(result)
            results[keyword] = results_count if results_count > 0
          end
        end
      end
  
      combined_keywords = keywords.select { |kw| keyword_counts[kw] && keyword_counts[kw] > 25 }
      if combined_keywords.any?
        used_keywords = []
  
        combined_keywords.each_slice(3) do |keyword_group|
          combined_keyword_string = keyword_group.join(' ')
          unique_combined_keywords = combined_keyword_string.split.uniq.join(' ')
          combined_results = Icdo.search_by_paragraph(unique_combined_keywords)
          combined_results_count = combined_results.count
          if combined_results_count <=25
            combined_results.each do |result|
              icdo_results << result unless icdo_results.include?(result)
              results_count = combined_results.count
              results[unique_combined_keywords] = results_count if results_count > 0
            end
          end
    
          puts "Further combined search results for: #{unique_combined_keywords}"
          puts "Total further combined results count: #{combined_results.count}"
          used_keywords.concat(unique_combined_keywords.split)
        end
      end
    else
    
      icdo_results = Icdo.all.to_a
    end
    puts "Total icdo_results count: #{icdo_results.count}"
    puts "Results_count: #{results}"
    
    icdo_results
  end

  def self.drop_down(params = {})
    results = []

    conn = ActiveRecord::Base.connection

    results = conn.execute(%{
      SELECT DISTINCT
        icdos.id,
        icdos.icdo_32 || ' ' || icdos.term_used AS term
      FROM icdos
      WHERE TRUE
      #{"AND icdos.id IN (#{params[:icdo_ids].join(',')})" if params[:icdo_ids].present?}
      ORDER BY icdos.id
    }).to_a

    results
  end

end
