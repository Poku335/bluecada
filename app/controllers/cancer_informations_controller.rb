class CancerInformationsController < ApplicationController
  before_action :set_cancer_information, only: %i[ show update destroy ]

  # GET /cancer_informations
  # GET /cancer_informations.json
  def index
    @cancer_informations = CancerInformation.all
    render json: @cancer_informations
  end

  # GET /cancer_informations/1
  # GET /cancer_informations/1.json
  def show
    render json: @cancer_information
  end

  def update_icdo
    @cancer_information = CancerInformation.update_icdo(params)
    render json: @cancer_information
  end

  # POST /cancer_informations
  # POST /cancer_informations.json
  def create
    @cancer_information = CancerInformation.new(cancer_information_params)

    if @cancer_information.save
      render json: @cancer_information, status: :created, location: @cancer_information
    else
      render json: @cancer_information.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cancer_informations/1
  # PATCH/PUT /cancer_informations/1.json
  def update
    if @cancer_information.update(cancer_information_params)
      render json: @cancer_information
    else
      render json: @cancer_information.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cancer_informations/1
  # DELETE /cancer_informations/1.json
  def destroy
    @cancer_information.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cancer_information
      @cancer_information = CancerInformation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cancer_information_params
      params.require(:cancer_information).permit(:topography_description,:case_type_id, :basis_id, :topography_code_id, :laterality_id, :morphology_description, :behavior_id, :lab_id, :lab_num, :lab_date, :t_stage, :n_stage, :m_stage, :stage_id, :stage_other, :extent_id, :metastasis_site_id, :is_recrr, :recurr_date, :grad_id, :icdo_id, :icd_10, :age_at_diagnosis, :diagnosis_date, :remark1, :remark2, :remark3, :remark4, :diagnosis_age, :date_stage, :postneo_tnm, :postneo_date, :type_stage_id, :figo_id, :bclc_id, :postneo_id, :postneo_staging_id, :ecog_id)
    end
end
