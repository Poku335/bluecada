class InformationDiagnosesController < ApplicationController
  before_action :set_information_diagnosis, only: %i[ show update destroy ]

  # GET /information_diagnoses
  # GET /information_diagnoses.json
  def index
    @information_diagnoses = InformationDiagnosis.all
  end

  # GET /information_diagnoses/1
  # GET /information_diagnoses/1.json
  def show
    render json: @information_diagnosis
  end

  # POST /information_diagnoses
  # POST /information_diagnoses.json
  def create
    @information_diagnosis = InformationDiagnosis.new(information_diagnosis_params)

    if @information_diagnosis.save
      render json: @information_diagnosis, status: :created
    else
      render json: @information_diagnosis.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /information_diagnoses/1
  # PATCH/PUT /information_diagnoses/1.json
  def update
    if @information_diagnosis.update(information_diagnosis_params)
      render json: @information_diagnosis, status: :ok
    else
      render json: @information_diagnosis.errors, status: :unprocessable_entity
    end
  end

  # DELETE /information_diagnoses/1
  # DELETE /information_diagnoses/1.json
  def destroy
    @information_diagnosis.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_information_diagnosis
      @information_diagnosis = InformationDiagnosis.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def information_diagnosis_params
      params.require(:information_diagnosis).permit(:tumor_marker_ca_19, :tumor_marker_cea, :tumor_marker_her_2, :tumor_marker_afp, :tumor_marker_hcg, :tumor_marker_psa, :tumor_suppressor_gene_brca_1, :tumor_suppressor_gene_brca_2)
    end
end
