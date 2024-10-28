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
    params[:order] = params[:order] || "#{table_name}.id"

    # diagnose_paragraphs = DiagnoseParagraph.where(cancer_information_id: params[:cancer_information_id]) 
    data = super(params.merge!(data: data))
    
  end

  def self.drop_down(params = {})
    results = []

    conn = ActiveRecord::Base.connection

    results = conn.execute(%{
      SELECT DISTINCT
        icdos.id,
        icdos.icdo_32 || ' ' || icdos.term_used AS term
      FROM search_icdos
      LEFT OUTER JOIN icdos ON icdos.id = search_icdos.icdo_id
      WHERE TRUE
      #{"AND search_icdos.diagnose_paragraph_id IN (#{params[:diagnose_paragraph_ids].join(',')})" if params[:diagnose_paragraph_ids].present?}
      #{"AND icdos.id IN (#{params[:icdo_ids].join(',')})" if params[:icdo_ids].present?}
    }).to_a

    results
  end

end
