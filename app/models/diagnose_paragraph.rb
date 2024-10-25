class DiagnoseParagraph < ApplicationRecord
  belongs_to :cancer_information
  has_many :search_icdos
  
  def as_json(options = {})
    # cache_key = "diagnose_paragraph_#{self.id}_as_json"
    # Rails.cache.fetch(cache_key, expires_in: 12.hours) do
    super(options.merge(except: [:cancerinformation_id])).merge(
      search_count: search_icdos.count,
      search_icdos: search_icdos.map do |search_icdo|
        search_icdo.as_json.merge(icdo: search_icdo.icdo)
      end
    )
    # end
  end
  
  def self.search(params = {})  
    data = all
    data = data.select %(
      diagnose_paragraphs.*
    )
      
    # data = data.where("diagnose_paragraphs.id in (#{params[:ids]})") if params[:ids].present?

    data = data.where("diagnose_paragraphs.id in (#{params[:ids].join(",")})") if params[:ids].present?
  
    params[:inner_joins] = %i[]
    params[:left_joins] = %i[]
    params[:keywords_columns] = []
    params[:order] = params[:order] || "diagnose_paragraphs.id"


    data = super(params.merge!(data: data))
  end


  def self.import_diag_paragraph(params = {})
    if params[:file].present?
      input_file = params[:file].path
      output_file = "#{Rails.root}/tmp/preprocessed_#{File.basename(input_file)}"
      
      safe_input_file = Rails.root.join('tmp', File.basename(input_file)).to_s

      FileUtils.cp(input_file, safe_input_file)
      
      ImportDiagParagraphJob.perform_later(safe_input_file, output_file)
      
      { message: "Data import started. You will be notified once it's completed." }
    else
      { error: "No file uploaded" }
    end
  end

end
