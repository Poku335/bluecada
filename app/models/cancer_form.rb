class CancerForm < ApplicationRecord
  belongs_to :current_user, class_name: 'User',  foreign_key: "current_user_id", optional: true
  belongs_to :treatment_follow_up, optional: true, dependent: :destroy
  belongs_to :information_diagnosis, optional: true, dependent: :destroy
  belongs_to :treatment_information, optional: true, dependent: :destroy
  belongs_to :cancer_information, optional: true, dependent: :destroy
  belongs_to :patient 
  belongs_to :cancer_form_status, optional: true
  # before_create :generate_tumor_id

  def as_json(options = {})
    hsh = super(options.merge(except: [ :current_user_id])).merge(
      current_user_id: current_user&.id
      # current_user: current_user,
    )
    hsh
  end

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

  def self.check_editing(params)
    user_id = params[:user_id].to_i
    user = User.find_by(id: user_id)
    cancer_form = CancerForm.find_by(id: params[:cancer_form_id])
  
    if cancer_form.nil?
      return { error: "CancerForm not found", can_edit: false }
    end
    p "cancer_form.is_editing #{cancer_form.is_editing} cancer_form.current_user_id #{cancer_form.current_user_id} user_id #{user_id}"
    if cancer_form.is_editing == true && cancer_form.current_user.id == user_id
      { cancer_form: cancer_form, message: "This form is currently being edited by you", can_edit: true }
    else
      if cancer_form.is_editing == false
        if cancer_form.update(is_editing: true, current_user: user)
          { cancer_form: cancer_form, message: "This form is now being edited by you", can_edit: true }
        else
          { error: "Failed to update editing status", can_edit: false }
        end
      else
        { error: "This form is currently being edited by another user", can_edit: false }
      end
    end
  end

  def self.change_editing_status(cancer_form_id)
    cancer_form = CancerForm.find_by(id: cancer_form_id)
    cancer_form.update(is_editing: false, current_user: nil)
    { cancer_form: cancer_form, message: "Editing status has been changed" }
  end


  def self.cancer_form
    @cancer_forms = CancerForm.all
    if params[:patient_id] && params[:primary]
    cancer_form = CancerForm.find_by(patient_id: params[:patient_id], primary: params[:primary])
       cancer_form
    else
      @cancer_forms
    end
  end

  def self.generate_tumor_id(diagnosis_date, cancer_information_id)
    hospital_code = "01"
    current_year = diagnosis_date.year + 543
    year_code = current_year.to_s[-2..-1]
    last_tumor_id = CancerForm.order(:created_at).last&.tumor_id
    if last_tumor_id.present?
      last_sequence = last_tumor_id[-4..-1].to_i
      new_sequence = last_sequence + 1
    else
      new_sequence = 1
    end
    sequence_code = new_sequence.to_s.rjust(4, '0')
    cancer_form = CancerForm.find_by(cancer_information_id: cancer_information_id)
    tumor_no = "#{hospital_code}#{year_code}#{sequence_code}"
    cancer_form.update(tumor_id: tumor_no)
  end

end

