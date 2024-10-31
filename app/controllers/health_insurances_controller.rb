class HealthInsurancesController < ApplicationController
  before_action :set_health_insurance, only: %i[ show update destroy ]

  # GET /health_insurances
  # GET /health_insurances.json
  def index
    @health_insurances = HealthInsurance.search(params)
      render json: @health_insurances
  end

  # GET /health_insurances/1
  # GET /health_insurances/1.json
  def show
    render json: @health_insurance
  end

  # POST /health_insurances
  # POST /health_insurances.json
  def create
    @health_insurance = HealthInsurance.new(health_insurance_params)

    if @health_insurance.save
      render json: @health_insurance
    else
      render json: @health_insurance.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /health_insurances/1
  # PATCH/PUT /health_insurances/1.json
  def update
    if @health_insurance.update(health_insurance_params)
      render json: @health_insurance
    else
      render json: @health_insurance.errors, status: :unprocessable_entity
    end
  end

  # DELETE /health_insurances/1
  # DELETE /health_insurances/1.json
  def destroy
    @health_insurance.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_health_insurance
      @health_insurance = HealthInsurance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def health_insurance_params
      params.require(:health_insurance).permit(:code, :name)
    end
end
