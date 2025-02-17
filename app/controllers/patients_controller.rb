class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.search(params)
    render json: @patients
  end

  # GET /patients/cancer_statistics
  def cancer_statistics
    @cancer_statistics = Patient.cancer_statistics
    render json: @cancer_statistics
  end

  def cancer_statistics_all_years
    statistics = Patient.cancer_statistics_all_years
    render json: statistics
  end
  

  # GET /patients/cancer_statistics_year/year
  # def cancer_statistics_year
  #   year = params[:year]  
  #   @cancer_statistics_year = Patient.cancer_statistics_year(year)
  #   render json: @cancer_statistics_year
  # end

  def import_patient
    @patients = Patient.import_patient(params)
    render json: @patients
  end

  def export_patients
    csv_file_path = Patient.export_patients(params)
    send_file csv_file_path, type: 'text/csv', disposition: 'attachment', filename: 'Exported_patient_datas.csv'
  end

  def preview_data_patients
    @patients = Patient.preview_patients(params)
    render json: @patients
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    render json: @patient
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      form = @patient.create_form_data
      render json: { patient: @patient, form: form }
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    if @patient.update(patient_params)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy!
    render json: { message: "Patient id #{@patient.id} deleted successfully" }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def patient_params
    params.require(:patient).permit(:hos_no, :hospital_id, :name, :citizen_id, :sex_id, :age, :birth_date, :address_detail, :post_code_id, :address_code_id, :marital_status_id, :race_id, :religion_id, :health_insurance_id, :regis_date, :id_finding, :province_id, :district_id, :sub_district_id, :icdo_10_date , :present_id)
  end
end
