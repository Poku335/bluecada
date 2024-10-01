class SubDistrictsController < ApplicationController
  before_action :set_sub_district, only: %i[ show update destroy ]

  # GET /sub_districts
  # GET /sub_districts.json
  def index
    sub_districts = SubDistrict.search_sub_districts(params)
    render json: sub_districts
  end

  # GET /sub_districts/1
  # GET /sub_districts/1.json
  def show
    render json: @sub_district
  end

  # POST /sub_districts
  # POST /sub_districts.json
  def create
    @sub_district = SubDistrict.new(sub_district_params)

    if @sub_district.save
      render :show, status: :created, location: @sub_district
    else
      render json: @sub_district.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sub_districts/1
  # PATCH/PUT /sub_districts/1.json
  def update
    if @sub_district.update(sub_district_params)
      render :show, status: :ok, location: @sub_district
    else
      render json: @sub_district.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sub_districts/1
  # DELETE /sub_districts/1.json
  def destroy
    @sub_district.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_district
      @sub_district = SubDistrict.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sub_district_params
      params.require(:sub_district).permit(:sub_district_id, :sub_district_thai_short, :sub_district_eng_short, :district_id)
    end
end
