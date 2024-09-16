class SearchIcdosController < ApplicationController
  before_action :set_search_icdo, only: %i[ show update destroy ]

  # GET /search_icdos
  # GET /search_icdos.json
  def index
    @search_icdos = SearchIcdo.all
  end

  # GET /search_icdos/1
  # GET /search_icdos/1.json
  def show
    render json: @search_icdo
  end

  # POST /search_icdos
  # POST /search_icdos.json
  def create
    @search_icdo = SearchIcdo.new(search_icdo_params)

    if @search_icdo.save
      render :show, status: :created, location: @search_icdo
    else
      render json: @search_icdo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /search_icdos/1
  # PATCH/PUT /search_icdos/1.json
  def update
    if @search_icdo.update(search_icdo_params)
      render :show, status: :ok, location: @search_icdo
    else
      render json: @search_icdo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /search_icdos/1
  # DELETE /search_icdos/1.json
  def destroy
    @search_icdo.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_icdo
      @search_icdo = SearchIcdo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def search_icdo_params
      params.require(:search_icdo).permit(:diagnose_paragraph_id, :icdo_id)
    end
end
