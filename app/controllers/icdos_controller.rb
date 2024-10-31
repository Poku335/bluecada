class IcdosController < ApplicationController
  before_action :set_icdo, only: %i[ show update destroy ]

  def drop_down
    icdo_results = Icdo.drop_down(params)
    render json: icdo_results
  end

  # GET /icdos
  # GET /icdos.json
  # def index
  #   @icdos = Icdo.all
  # end
  def index
    icdo_results = Icdo.search_icdo_codes(params)
    render json: icdo_results
  end
  

  # GET /icdos/1
  # GET /icdos/1.json
  def show
  end

  # POST /icdos
  # POST /icdos.json
  def create
    @icdo = Icdo.new(icdo_params)

    if @icdo.save
      render :show, status: :created, location: @icdo
    else
      render json: @icdo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /icdos/1
  # PATCH/PUT /icdos/1.json
  def update
    if @icdo.update(icdo_params)
      render :show, status: :ok, location: @icdo
    else
      render json: @icdo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /icdos/1
  # DELETE /icdos/1.json
  def destroy
    @icdo.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_icdo
      @icdo = Icdo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def icdo_params
      params.require(:icdo).permit(:idd, :beh, :cancer_type, :icdo_32, :icdo_32_c, :level, :term_used, :term_raw)
    end
end
