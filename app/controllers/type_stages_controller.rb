class TypeStagesController < ApplicationController
  before_action :set_type_stage, only: %i[ show edit update destroy ]

  # GET /type_stages
  # GET /type_stages.json
  def index
    @type_stages = TypeStage.all
    render json: @type_stages
  end

  # GET /type_stages/1
  # GET /type_stages/1.json
  def show
    render json: @type_stage
  end

  # POST /type_stages
  # POST /type_stages.json
  def create
    @type_stage = TypeStage.new(type_stage_params)

    if @type_stage.save
      render :show, status: :created, location: @type_stage
    else
      render json: @type_stage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /type_stages/1
  # PATCH/PUT /type_stages/1.json
  def update
    if @type_stage.update(type_stage_params)
      render :show, status: :ok, location: @type_stage
    else
      render json: @type_stage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /type_stages/1
  # DELETE /type_stages/1.json
  def destroy
    @type_stage.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_stage
      @type_stage = TypeStage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def type_stage_params
      params.require(:type_stage).permit(:name, :code)
    end
end
