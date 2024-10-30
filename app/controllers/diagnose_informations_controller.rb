class DiagnoseInformationsController < ApplicationController
  before_action :set_diagnose_information, only: %i[ show update destroy ]

  # GET /diagnose_informations
  # GET /diagnose_informations.json
  def index
    @diagnose_informations = DiagnoseInformation.all
  end

  # GET /diagnose_informations/1
  # GET /diagnose_informations/1.json
  def show
    render json: @diagnose_information
  end

  # POST /diagnose_informations
  # POST /diagnose_informations.json
  def create
    @diagnose_information = DiagnoseInformation.new(diagnose_information_params)

    if @diagnose_information.save
      render :show, status: :created, location: @diagnose_information
    else
      render json: @diagnose_information.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /diagnose_informations/1
  # PATCH/PUT /diagnose_informations/1.json
  def update
    if @diagnose_information.update(diagnose_information_params)
      render :show, status: :ok, location: @diagnose_information
    else
      render json: @diagnose_information.errors, status: :unprocessable_entity
    end
  end

  # DELETE /diagnose_informations/1
  # DELETE /diagnose_informations/1.json
  def destroy
    @diagnose_information.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagnose_information
      @diagnose_information = DiagnoseInformation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def diagnose_information_params
      params.require(:diagnose_information).permit(:diagnose_paragraph, :cancer_information_id, :diag_date)
    end
end
