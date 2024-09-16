class TreatmentFollowUpsController < ApplicationController
  before_action :set_treatment_follow_up, only: %i[ show update destroy ]

  # GET /treatment_follow_ups
  # GET /treatment_follow_ups.json
  def index
    @treatment_follow_ups = TreatmentFollowUp.all
    render json: @treatment_follow_ups
  end

  # GET /treatment_follow_ups/1
  # GET /treatment_follow_ups/1.json
  def show
    render json: @treatment_follow_up
  end

  # POST /treatment_follow_ups
  # POST /treatment_follow_ups.json
  def create
    @treatment_follow_up = TreatmentFollowUp.new(treatment_follow_up_params)

    if @treatment_follow_up.save
      render json: @treatment_follow_up, status: :created, location: @treatment_follow_up
    else
      render json: @treatment_follow_up.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /treatment_follow_ups/1
  # PATCH/PUT /treatment_follow_ups/1.json
  def update
    if @treatment_follow_up.update(treatment_follow_up_params)
      render json: @treatment_follow_up
    else
      render json: @treatment_follow_up.errors, status: :unprocessable_entity
    end
  end

  # DELETE /treatment_follow_ups/1
  # DELETE /treatment_follow_ups/1.json
  def destroy
    @treatment_follow_up.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment_follow_up
      @treatment_follow_up = TreatmentFollowUp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def treatment_follow_up_params
      params.require(:treatment_follow_up).permit(:present_id, :dls, :death_stat_id, :refer_from_id, :date_refer_from, :refer_to_id, :date_refer_to)
    end
end
