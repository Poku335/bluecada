class ProvincesController < ApplicationController
  before_action :set_province, only: %i[ show update destroy ]

  # GET /provinces
  # GET /provinces.json
  def index
    @provinces = Province.all
    render json: @provinces
  end

  # GET /provinces/1
  # GET /provinces/1.json
  def show
  end

  # POST /provinces
  # POST /provinces.json
  def create
    @province = Province.new(province_params)

    if @province.save
      render :show, status: :created, location: @province
    else
      render json: @province.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /provinces/1
  # PATCH/PUT /provinces/1.json
  def update
    if @province.update(province_params)
      render :show, status: :ok, location: @province
    else
      render json: @province.errors, status: :unprocessable_entity
    end
  end

  # DELETE /provinces/1
  # DELETE /provinces/1.json
  def destroy
    @province.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_province
      @province = Province.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def province_params
      params.require(:province).permit(:province_id, :province_thai, :province_eng, :region)
    end
end
