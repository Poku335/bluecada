class LateralitiesController < ApplicationController
  before_action :set_laterality, only: %i[ show update destroy ]

  # GET /lateralities
  # GET /lateralities.json
  def index
    @lateralities = Laterality.all
      render json: @lateralities
  end

  # GET /lateralities/1
  # GET /lateralities/1.json
  def show
    render json: @laterality
  end

  # POST /lateralities
  # POST /lateralities.json
  def create
    @laterality = Laterality.new(laterality_params)

    if @laterality.save
      render :show, status: :created, location: @laterality
    else
      render json: @laterality.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lateralities/1
  # PATCH/PUT /lateralities/1.json
  def update
    if @laterality.update(laterality_params)
      render :show, status: :ok, location: @laterality
    else
      render json: @laterality.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lateralities/1
  # DELETE /lateralities/1.json
  def destroy
    @laterality.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_laterality
      @laterality = Laterality.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def laterality_params
      params.require(:laterality).permit(:code, :name)
    end
end
