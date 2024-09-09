class CancerForm < ApplicationRecord
  belongs_to :current_user
  belongs_to :treatment_follow_up
  belongs_to :information_diagnose
  belongs_to :treatment_information
  belongs_to :cancer_information
  belongs_to :patient
  belongs_to :cancer_form_status
end
