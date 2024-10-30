class ImportPatientsController < ApplicationController
  before_action :set_import_patient, only: %i[ show update destroy ]

  # GET /import_patients
  # GET /import_patients.json
  def index
    @import_patients = ImportPatient.all
  end

  # GET /import_patients/1
  # GET /import_patients/1.json
  def show
    render json: @import_patient
  end

  # POST /import_patients
  # POST /import_patients.json
  def create
    @import_patient = ImportPatient.new(import_patient_params)

    if @import_patient.save
      render :show, status: :created, location: @import_patient
    else
      render json: @import_patient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /import_patients/1
  # PATCH/PUT /import_patients/1.json
  def update
    if @import_patient.update(import_patient_params)
      render :show, status: :ok, location: @import_patient
    else
      render json: @import_patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /import_patients/1
  # DELETE /import_patients/1.json
  def destroy
    @import_patient.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import_patient
      @import_patient = ImportPatient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def import_patient_params
      params.require(:import_patient).permit(:date, :total_patient_count, :new_patient_count, :existing_patient_count, :error_patient_count)
    end
end
