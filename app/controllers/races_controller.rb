class RacesController < ApplicationController
  before_action :set_race, only: %i[ show update destroy ]

  # GET /races
  # GET /races.json
  def index
    @races = Race.all
  end

  # GET /races/1
  # GET /races/1.json
  def show
  end

  # POST /races
  # POST /races.json
  def create
    @race = Race.new(race_params)

    if @race.save
      render :show, status: :created, location: @race
    else
      render json: @race.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /races/1
  # PATCH/PUT /races/1.json
  def update
    if @race.update(race_params)
      render :show, status: :ok, location: @race
    else
      render json: @race.errors, status: :unprocessable_entity
    end
  end

  # DELETE /races/1
  # DELETE /races/1.json
  def destroy
    @race.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def race_params
      params.require(:race).permit(:code, :name)
    end
end
