class MetastasisSitesController < ApplicationController
  before_action :set_metastasis_site, only: %i[ show update destroy ]

  # GET /metastasis_sites
  # GET /metastasis_sites.json
  def index
    @metastasis_sites = MetastasisSite.search(params)
    render json: @metastasis_sites
  end

  # GET /metastasis_sites/1
  # GET /metastasis_sites/1.json
  def show
    render json: @metastasis_site
  end

  # POST /metastasis_sites
  # POST /metastasis_sites.json
  def create
    @metastasis_site = MetastasisSite.new(metastasis_site_params)

    if @metastasis_site.save
      render json: @metastasis_site
    else
      render json: @metastasis_site.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /metastasis_sites/1
  # PATCH/PUT /metastasis_sites/1.json
  def update
    if @metastasis_site.update(metastasis_site_params)
      render json: @metastasis_site
    else
      render json: @metastasis_site.errors, status: :unprocessable_entity
    end
  end

  # DELETE /metastasis_sites/1
  # DELETE /metastasis_sites/1.json
  def destroy
    @metastasis_site.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metastasis_site
      @metastasis_site = MetastasisSite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def metastasis_site_params
      params.require(:metastasis_site).permit(:code, :name)
    end
end
