class LabsController < ApplicationController
  before_action :set_lab, only: %i[ show update destroy ]

  # GET /labs
  # GET /labs.json
  def index
    @labs = Lab.all
    render json: @labs
  end

  # GET /labs/1
  # GET /labs/1.json
  def show
  end

  # POST /labs
  # POST /labs.json
  def create
    @lab = Lab.new(lab_params)

    if @lab.save
      render :show, status: :created, location: @lab
    else
      render json: @lab.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /labs/1
  # PATCH/PUT /labs/1.json
  def update
    if @lab.update(lab_params)
      render :show, status: :ok, location: @lab
    else
      render json: @lab.errors, status: :unprocessable_entity
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @lab.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lab
      @lab = Lab.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lab_params
      params.require(:lab).permit(:code, :name)
    end
end
