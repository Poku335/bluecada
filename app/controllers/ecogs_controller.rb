class EcogsController < ApplicationController
  before_action :set_ecog, only: %i[ show edit update destroy ]

  # GET /ecogs
  # GET /ecogs.json
  def index
    @ecogs = Ecog.all
    render json: @ecogs
  end

  # GET /ecogs/1
  # GET /ecogs/1.json
  def show
    render json: @ecog
  end

  # POST /ecogs
  # POST /ecogs.json
  def create
    @ecog = Ecog.new(ecog_params)

    if @ecog.save
      render :show, status: :created, location: @ecog
    else
      render json: @ecog.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ecogs/1
  # PATCH/PUT /ecogs/1.json
  def update
    if @ecog.update(ecog_params)
      render :show, status: :ok, location: @ecog
    else
      render json: @ecog.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ecogs/1
  # DELETE /ecogs/1.json
  def destroy
    @ecog.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ecog
      @ecog = Ecog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ecog_params
      params.require(:ecog).permit(:name, :code)
    end
end
