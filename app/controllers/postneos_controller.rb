class PostneosController < ApplicationController
  before_action :set_postneo, only: %i[ show edit update destroy ]

  # GET /postneos
  # GET /postneos.json
  def index
    @postneos = Postneo.all
    render json: @postneos
  end

  # GET /postneos/1
  # GET /postneos/1.json
  def show
    render json: @postneo
  end

  # POST /postneos
  # POST /postneos.json
  def create
    @postneo = Postneo.new(postneo_params)

    if @postneo.save
      render :show, status: :created, location: @postneo
    else
      render json: @postneo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /postneos/1
  # PATCH/PUT /postneos/1.json
  def update
    if @postneo.update(postneo_params)
      render :show, status: :ok, location: @postneo
    else
      render json: @postneo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /postneos/1
  # DELETE /postneos/1.json
  def destroy
    @postneo.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postneo
      @postneo = Postneo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def postneo_params
      params.require(:postneo).permit(:name, :code)
    end
end
