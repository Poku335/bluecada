class TopographyCodesController < ApplicationController
  before_action :set_topography_code, only: %i[ show update destroy ]

  # GET /topography_codes
  # GET /topography_codes.json
  def index
    @topography_codes = TopographyCode.search(params)
    render json: @topography_codes
  end

  # GET /topography_codes/1
  # GET /topography_codes/1.json
  def show
    render json: @topography_code
  end

  # POST /topography_codes
  # POST /topography_codes.json
  def create
    @topography_code = TopographyCode.new(topography_code_params)

    if @topography_code.save
      render :show, status: :created, location: @topography_code
    else
      render json: @topography_code.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /topography_codes/1
  # PATCH/PUT /topography_codes/1.json
  def update
    if @topography_code.update(topography_code_params)
      render :show, status: :ok, location: @topography_code
    else
      render json: @topography_code.errors, status: :unprocessable_entity
    end
  end

  # DELETE /topography_codes/1
  # DELETE /topography_codes/1.json
  def destroy
    @topography_code.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topography_code
      @topography_code = TopographyCode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topography_code_params
      params.require(:topography_code).permit(:code, :icd_10, :name)
    end
end
