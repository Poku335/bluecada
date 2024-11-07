class FigosController < ApplicationController
  before_action :set_figo, only: %i[ show edit update destroy ]

  # GET /figos
  # GET /figos.json
  def index
    @figos = Figo.all
    render json: @figos
  end

  # GET /figos/1
  # GET /figos/1.json
  def show
    render json: @figo
  end

  # POST /figos
  # POST /figos.json
  def create
    @figo = Figo.new(figo_params)

    if @figo.save
      render :show, status: :created, location: @figo
    else
      render json: @figo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /figos/1
  # PATCH/PUT /figos/1.json
  def update
    if @figo.update(figo_params)
      render :show, status: :ok, location: @figo
    else
      render json: @figo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /figos/1
  # DELETE /figos/1.json
  def destroy
    @figo.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_figo
      @figo = Figo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def figo_params
      params.require(:figo).permit(:name, :code)
    end
end
