class PresentsController < ApplicationController
  before_action :set_present, only: %i[ show update destroy ]

  # GET /presents
  # GET /presents.json
  def index
    @presents = Present.all
    render json: @presents
  end

  # GET /presents/1
  # GET /presents/1.json
  def show
    render json: @present
  end

  # POST /presents
  # POST /presents.json
  def create
    @present = Present.new(present_params)

    if @present.save
      render :show, status: :created, location: @present
    else
      render json: @present.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /presents/1
  # PATCH/PUT /presents/1.json
  def update
    if @present.update(present_params)
      render :show, status: :ok, location: @present
    else
      render json: @present.errors, status: :unprocessable_entity
    end
  end

  # DELETE /presents/1
  # DELETE /presents/1.json
  def destroy
    @present.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_present
      @present = Present.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def present_params
      params.require(:present).permit(:code, :name)
    end
end
