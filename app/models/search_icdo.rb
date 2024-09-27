class SearchIcdo < ApplicationRecord
  belongs_to :diagnose_paragraph
  belongs_to :icdo


  def self.search(params = {})
    start_date = params[:start_date]
    start_time = params[:start_time] || '00:00:00'
    end_date = params[:end_date]
    end_time = params[:end_time] || '23:59:59'

    data = all

    # ถ้ามี diagnose_paragraph_id ก็จะทำการ join กับ diagnose_paragraph
    if params[:cancer_information_id].present?
      data = data.joins(diagnose_paragraph: :cancer_information)
                .where(cancer_informations: { id: params[:cancer_information_id] })
    end

    # เลือกเฉพาะข้อมูลที่ต้องการ
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

    diagnose_paragraphs = DiagnoseParagraph.where(cancer_information_id: params[:cancer_information_id])
    data = super(params.merge!(data: data)).merge(diagnose_paragraphs: diagnose_paragraphs)
    
  end

end
