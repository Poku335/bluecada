class BehaviorsController < ApplicationController
  before_action :set_behavior, only: %i[ show update destroy ]

  # GET /behaviors
  # GET /behaviors.json
  def index
    @behaviors = Behavior.all
      render json: @behaviors
  end

  # GET /behaviors/1
  # GET /behaviors/1.json
  def show
  end

  # POST /behaviors
  # POST /behaviors.json
  def create
    @behavior = Behavior.new(behavior_params)

    if @behavior.save
      render :show, status: :created, location: @behavior
    else
      render json: @behavior.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /behaviors/1
  # PATCH/PUT /behaviors/1.json
  def update
    if @behavior.update(behavior_params)
      render :show, status: :ok, location: @behavior
    else
      render json: @behavior.errors, status: :unprocessable_entity
    end
  end

  # DELETE /behaviors/1
  # DELETE /behaviors/1.json
  def destroy
    @behavior.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_behavior
      @behavior = Behavior.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def behavior_params
      params.require(:behavior).permit(:code, :name)
    end
end
