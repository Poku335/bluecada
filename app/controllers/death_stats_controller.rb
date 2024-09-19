class DeathStatsController < ApplicationController
  before_action :set_death_stat, only: %i[ show update destroy ]

  # GET /death_stats
  # GET /death_stats.json
  def index
    @death_stats = DeathStat.all
    render json: @death_stats
  end

  # GET /death_stats/1
  # GET /death_stats/1.json
  def show
    render json: @death_stat
  end

  # POST /death_stats
  # POST /death_stats.json
  def create
    @death_stat = DeathStat.new(death_stat_params)

    if @death_stat.save
      render :show, status: :created, location: @death_stat
    else
      render json: @death_stat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /death_stats/1
  # PATCH/PUT /death_stats/1.json
  def update
    if @death_stat.update(death_stat_params)
      render :show, status: :ok, location: @death_stat
    else
      render json: @death_stat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /death_stats/1
  # DELETE /death_stats/1.json
  def destroy
    @death_stat.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_death_stat
      @death_stat = DeathStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def death_stat_params
      params.require(:death_stat).permit(:code, :name)
    end
end
