class TreatmentInformationsController < ApplicationController
  before_action :set_treatment_information, only: %i[ show update destroy ]

  # GET /treatment_informations
  # GET /treatment_informations.json
  def index
    @treatment_informations = TreatmentInformation.all
      render json: @treatment_informations
  end

  # GET /treatment_informations/1
  # GET /treatment_informations/1.json
  def show
    render json: @treatment_information
  end

  # POST /treatment_informations
  # POST /treatment_informations.json
  def create
    @treatment_information = TreatmentInformation.new(treatment_information_params)

    if @treatment_information.save
      render json: @treatment_information, status: :created
    else
      render json: @treatment_information.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /treatment_informations/1
  # PATCH/PUT /treatment_informations/1.json
  def update
    if @treatment_information.update(treatment_information_params)
      render json: @treatment_information, status: :ok
    else
      render json: @treatment_information.errors, status: :unprocessable_entity
    end
  end

  # DELETE /treatment_informations/1
  # DELETE /treatment_informations/1.json
  def destroy
    @treatment_information.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment_information
      @treatment_information = TreatmentInformation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def treatment_information_params
      params.require(:treatment_information).permit(:is_surg, :date_surg, :is_radia, :date_radia, :is_chemo, :date_chemo, :is_target, 
      :date_target, :is_hormone, :date_hormone, :is_immu, :date_immu, :is_inter_the, :date_inter_the, :is_nuclear, :date_nuclear, 
      :is_stem_cell, :date_stem_cell, :is_bone_scan, :date_bone_scan, :is_supportive, :is_treatment)
    end
end
