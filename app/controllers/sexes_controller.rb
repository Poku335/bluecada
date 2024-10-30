class SexesController < ApplicationController
  before_action :set_sex, only: %i[ show update destroy ]

  # GET /sexes
  # GET /sexes.json
  def index
    @sexes = Sex.all
  end

  # GET /sexes/1
  # GET /sexes/1.json
  def show
    render json: @sex
  end

  # POST /sexes
  # POST /sexes.json
  def create
    @sex = Sex.new(sex_params)

    if @sex.save
      render :show, status: :created, location: @sex
    else
      render json: @sex.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sexes/1
  # PATCH/PUT /sexes/1.json
  def update
    if @sex.update(sex_params)
      render :show, status: :ok, location: @sex
    else
      render json: @sex.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sexes/1
  # DELETE /sexes/1.json
  def destroy
    @sex.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sex
      @sex = Sex.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sex_params
      params.require(:sex).permit(:code, :name)
    end
end
