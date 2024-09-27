class DiagnoseParagraph < ApplicationRecord
  belongs_to :cancer_information
  has_many :search_icdos

  
  # def as_json(options = {})
  #   # cache_key = "diagnose_paragraph_#{self.id}_as_json"
  #   # Rails.cache.fetch(cache_key, expires_in: 12.hours) do
  #     super(options.merge(except: [:cancerinformation_id])).merge(
  #       search_count: search_icdos.count,
  #       search_icdos: search_icdos.map do |search_icdo|
  #         search_icdo.as_json.merge(icdo: search_icdo.icdo)
  #       end
  #     )
  #   # end
  # end

end
