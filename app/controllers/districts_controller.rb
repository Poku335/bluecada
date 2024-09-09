class DistrictsController < ApplicationController
  before_action :set_district, only: %i[ show update destroy ]

  # GET /districts
  # GET /districts.json
  def index
    @districts = District.all
  end

  # GET /districts/1
  # GET /districts/1.json
  def show
  end

  # POST /districts
  # POST /districts.json
  def create
    @district = District.new(district_params)

    if @district.save
      render :show, status: :created, location: @district
    else
      render json: @district.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /districts/1
  # PATCH/PUT /districts/1.json
  def update
    if @district.update(district_params)
      render :show, status: :ok, location: @district
    else
      render json: @district.errors, status: :unprocessable_entity
    end
  end

  # DELETE /districts/1
  # DELETE /districts/1.json
  def destroy
    @district.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_district
      @district = District.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def district_params
      params.require(:district).permit(:district_id, :district_thai_short, :district_eng_short, :district_cnt, :province_id)
    end
end
