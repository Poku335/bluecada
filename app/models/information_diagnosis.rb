class InformationDiagnosis < ApplicationRecord

  # attr_accessor :case_type_id

  # before_update :update_case_type

  # def update_case_type
  #   cancer_form = CancerForm.find_by(information_diagnosis_id: self.id) if self.id.present?
  #   cancer_form.cancer_information.update(case_type_id: self.case_type_id) if cancer_form.present?
  # end

end
