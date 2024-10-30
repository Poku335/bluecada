class MaritalStatusesController < ApplicationController
  before_action :set_marital_status, only: %i[ show update destroy ]

  # GET /marital_statuses
  # GET /marital_statuses.json
  def index
    @marital_statuses = MaritalStatus.all
    render json: @marital_statuses
  end

  # GET /marital_statuses/1
  # GET /marital_statuses/1.json
  def show
    render json: @marital_status
  end

  # POST /marital_statuses
  # POST /marital_statuses.json
  def create
    @marital_status = MaritalStatus.new(marital_status_params)

    if @marital_status.save
      render :show, status: :created, location: @marital_status
    else
      render json: @marital_status.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marital_statuses/1
  # PATCH/PUT /marital_statuses/1.json
  def update
    if @marital_status.update(marital_status_params)
      render :show, status: :ok, location: @marital_status
    else
      render json: @marital_status.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marital_statuses/1
  # DELETE /marital_statuses/1.json
  def destroy
    @marital_status.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marital_status
      @marital_status = MaritalStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def marital_status_params
      params.require(:marital_status).permit(:code, :name)
    end
end
