class CancerForm < ApplicationRecord
  belongs_to :current_user, class_name: 'User', optional: true
  belongs_to :treatment_follow_up, optional: true
  belongs_to :information_diagnosis, optional: true
  belongs_to :treatment_information, optional: true
  belongs_to :cancer_information, optional: true
  belongs_to :patient
  belongs_to :cancer_form_status, optional: true
  before_create :create_form_data


  def create_form_data
    treatment_follow_up = TreatmentFollowUp.create!
    information_diagnosis = InformationDiagnosis.create!
    treatment_information = TreatmentInformation.create!
    cancer_information = CancerInformation.create!
    
    primary_value = CancerForm.where(patient_id: self.patient_id).count + 1
    self.is_editing = false
    self.treatment_follow_up_id = treatment_follow_up.id
    self.information_diagnosis_id = information_diagnosis.id
    self.cancer_information_id = cancer_information.id
    self.treatment_information_id = treatment_information.id
    self.primary = primary_value
    self.cancer_form_status_id = 1
  end

end

