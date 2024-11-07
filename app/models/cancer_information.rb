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
  belongs_to :type_stage
  belongs_to :figo
  belongs_to :bclc
  belongs_to :postneo
  belongs_to :postneo_staging
  belongs_to :ecog
  has_many :cancer_forms

  before_create :set_case_type
  before_update :check_tumor_id, :set_diagnosis_age

  def check_tumor_id
    case_type_id = self.case_type_id
    if self.diagnosis_date.present?
      case when case_type_id == 1
            CancerForm.update(tumor_id: nil)
           when case_type_id == 2
            CancerForm.generate_tumor_id(self.diagnosis_date, self.id)
          when case_type_id == 3
            CancerForm.update(tumor_id: nil)
          when case_type_id == 4
            CancerForm.generate_tumor_id(self.diagnosis_date, self.id)
          when case_type_id == 5
            CancerForm.generate_tumor_id(self.diagnosis_date, self.id)
      end
    end
  end

  def set_case_type
    self.case_type_id = 1
  end

  def set_diagnosis_age
    get_patient_birth_date = CancerForm.find_by(cancer_information_id: self.id)&.patient&.birth_date
    get_diagnosis_date = self.diagnosis_date
  
    if get_patient_birth_date.present? && get_diagnosis_date.present?
      self.diagnosis_age = ((get_diagnosis_date - get_patient_birth_date)/ 365.25).to_i
    else
      self.diagnosis_age = nil
    end
  end  

  def as_json(options = {})
    # icd10 = topography_code&.icd_10&.split('.')&.join('')
    hsh = super(options.merge(except: [:case_type_id, :basis_id, :topography_code_id, :laterality_id, :behavior_id, :lab_id, :stage_id, :stage_other_id, :extent_id, :metastasis_site_id, :grad_id])).merge(
      basis: basis,
      tumor_id: cancer_forms&.first&.tumor_id,
      topography_code: topography_code,
      case_type: case_type,
      laterality: laterality,
      behavior: behavior,
      lab: lab,
      stage: stage,
      stage_other: stage_other,
      extent: extent,
      metastasis_site: metastasis_site,
      grad: grad,
      type_stage: type_stage,
      figo: figo,
      bclc: bclc,
      postneo: postneo,
      postneo_staging: postneo_staging,
      ecog: ecog
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
