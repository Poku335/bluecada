class SearchIcdo < ApplicationRecord
  belongs_to :diagnose_paragraph
  belongs_to :icdo


  def self.search(params = {})

    data = all

    if params[:cancer_information_id].present?
      data = data.joins(diagnose_paragraph: :cancer_information)
                .where(cancer_informations: { id: params[:cancer_information_id] })

    # else
    #   puts "No cancer_information_id"
    end

    
    data = data.select %(
      search_icdos.*,
      icdos.icdo_32 AS icdo_code,
      icdos.term_used AS term
    )

    # ตั้งค่า joins
    params[:inner_joins] = %i[]
    params[:left_joins] = %i[diagnose_paragraphs icdos]
    params[:keywords_columns] = ["search_icdos.id"]
    params[:order] = params[:order] || "search_icdos.id"

    # diagnose_paragraphs = DiagnoseParagraph.where(cancer_information_id: params[:cancer_information_id]) 
    data = super(params.merge!(data: data))
    
  end

end
