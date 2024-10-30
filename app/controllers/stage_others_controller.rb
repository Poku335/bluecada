class StageOthersController < ApplicationController
  before_action :set_stage_other, only: %i[ show update destroy ]

  # GET /stage_others
  # GET /stage_others.json
  def index
    @stage_others = StageOther.all
    render json: @stage_others
  end

  # GET /stage_others/1
  # GET /stage_others/1.json
  def show
    render json: @stage_other
  end

  # POST /stage_others
  # POST /stage_others.json
  def create
    @stage_other = StageOther.new(stage_other_params)

    if @stage_other.save
      render :show, status: :created, location: @stage_other
    else
      render json: @stage_other.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stage_others/1
  # PATCH/PUT /stage_others/1.json
  def update
    if @stage_other.update(stage_other_params)
      render :show, status: :ok, location: @stage_other
    else
      render json: @stage_other.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stage_others/1
  # DELETE /stage_others/1.json
  def destroy
    @stage_other.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stage_other
      @stage_other = StageOther.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stage_other_params
      params.require(:stage_other).permit(:code, :name)
    end
end
