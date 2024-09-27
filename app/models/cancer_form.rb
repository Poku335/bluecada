class CancerForm < ApplicationRecord
  belongs_to :current_user, class_name: 'User', optional: true
  belongs_to :treatment_follow_up, optional: true
  belongs_to :information_diagnosis, optional: true
  belongs_to :treatment_information, optional: true
  belongs_to :cancer_information, optional: true
  belongs_to :patient
  belongs_to :cancer_form_status, optional: true


  def create_form_data
    ActiveRecord::Base.transaction do
      begin
        cancer_information = CancerInformation.create!
        
        treatment_follow_up = TreatmentFollowUp.create!
        
        information_diagnosis = InformationDiagnosis.create!
        
        treatment_information = TreatmentInformation.create!
        
        self.primary = self.patient.cancer_forms.count + 1
        self.is_editing = false
        self.cancer_information = cancer_information
        self.treatment_follow_up = treatment_follow_up
        self.information_diagnosis = information_diagnosis
        self.treatment_information = treatment_information
        self.cancer_form_status = CancerFormStatus.find(1) 
        
        self
      rescue => e
        Rails.logger.error "Failed to create related records for CancerForm - Error: #{e.message}"
        raise ActiveRecord::Rollback
      end
    end
  end

end

