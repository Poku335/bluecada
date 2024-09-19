class HospitalsController < ApplicationController
  before_action :set_hospital, only: %i[ show update destroy ]

  # GET /hospitals
  # GET /hospitals.json
  def index
    @hospitals = Hospital.all
    render json: @hospitals
  end

  # GET /hospitals/1
  # GET /hospitals/1.json
  def show
    render json: @hospital
  end

  # POST /hospitals
  # POST /hospitals.json
  def create
    @hospital = Hospital.new(hospital_params)

    if @hospital.save
      render :show, status: :created, location: @hospital
    else
      render json: @hospital.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hospitals/1
  # PATCH/PUT /hospitals/1.json
  def update
    if @hospital.update(hospital_params)
      render :show, status: :ok, location: @hospital
    else
      render json: @hospital.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hospitals/1
  # DELETE /hospitals/1.json
  def destroy
    @hospital.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hospital
      @hospital = Hospital.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hospital_params
      params.require(:hospital).permit(:code, :name)
    end
end
