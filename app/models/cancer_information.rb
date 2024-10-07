class CancerInformation < ApplicationRecord
  belongs_to :basis, optional: true
  belongs_to :topography_code, optional: true
  belongs_to :laterality, optional: true
  belongs_to :behavior, optional: true
  belongs_to :lab, optional: true
  belongs_to :stage, optional: true
  belongs_to :stage_other, optional: true
  belongs_to :extent, optional: true
  belongs_to :metastasis_site, optional: true
  belongs_to :grad, optional: true
  belongs_to :icdo, optional: true
  belongs_to :case_type, optional: true
  
  

  def as_json(options = {})
  # icd10 = topography_code&.icd_10&.split('.')&.join('')
    hsh = super(options.merge(except: [:case_type_id, :basis_id, :topography_code_id, :laterality_id, :behavior_id, :lab_id, :stage_id, :stage_other_id, :extent_id, :metastasis_site_id, :grad_id])).merge(
      basis: basis,
      topography_code: topography_code,
      case_type: case_type,
      laterality: laterality,
      behavior: behavior,
      lab: lab,
      stage: stage,
      stage_other: stage_other,
      extent: extent,
      metastasis_site: metastasis_site,
      grad: grad
    )
    hsh
  end

  def self.update_icdo(params)
    paragraph_id = params[:diagnose_paragraph_id]
    diag = DiagnoseParagraph.find(paragraph_id)
    date = diag&.diag_date
    cancer_information = diag&.cancer_information&.id
    if cancer_information
      diag.cancer_information.update(icdo_id: params[:icdo_id], lab_date: date)
    else
      { error: "Cancer information not found" }
    end
  end
  
end
