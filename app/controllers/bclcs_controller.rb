class BclcsController < ApplicationController
  before_action :set_bclc, only: %i[ show edit update destroy ]
  
  # GET /bclcs
  # GET /bclcs.json
  def index
    @bclcs = Bclc.all
    render json: @bclcs
  end

  # GET /bclcs/1
  # GET /bclcs/1.json
  def show
    render json: @bclc
  end

  # POST /bclcs
  # POST /bclcs.json
  def create
    @bclc = Bclc.new(bclc_params)

    if @bclc.save
      render :show, status: :created, location: @bclc
    else
      render json: @bclc.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bclcs/1
  # PATCH/PUT /bclcs/1.json
  def update
    if @bclc.update(bclc_params)
      render :show, status: :ok, location: @bclc
    else
      render json: @bclc.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bclcs/1
  # DELETE /bclcs/1.json
  def destroy
    @bclc.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bclc
      @bclc = Bclc.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bclc_params
      params.require(:bclc).permit(:name, :code)
    end
end
