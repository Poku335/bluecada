class StagesController < ApplicationController
  before_action :set_stage, only: %i[ show update destroy ]

  # GET /stages
  # GET /stages.json
  def index
    @stages = Stage.search(params)
    render json: @stages
  end

  # GET /stages/1
  # GET /stages/1.json
  def show
    render json: @stage
  end

  # POST /stages
  # POST /stages.json
  def create
    @stage = Stage.new(stage_params)

    if @stage.save
      render json: @stage
    else
      render json: @stage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stages/1
  # PATCH/PUT /stages/1.json
  def update
    if @stage.update(stage_params)
      render json: @stage
    else
      render json: @stage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stages/1
  # DELETE /stages/1.json
  def destroy
    @stage.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stage
      @stage = Stage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stage_params
      params.require(:stage).permit(:code, :name)
    end
end
