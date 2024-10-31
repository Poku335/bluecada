class ExtentsController < ApplicationController
  before_action :set_extent, only: %i[ show update destroy ]

  # GET /extents
  # GET /extents.json
  def index
    @extents = Extent.search(params)
    render json: @extents
  end

  # GET /extents/1
  # GET /extents/1.json
  def show
    render json: @extent
  end

  # POST /extents
  # POST /extents.json
  def create
    @extent = Extent.new(extent_params)

    if @extent.save
      render json: @extent
    else
      render json: @extent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /extents/1
  # PATCH/PUT /extents/1.json
  def update
    if @extent.update(extent_params)
      render json: @extent
    else
      render json: @extent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /extents/1
  # DELETE /extents/1.json
  def destroy
    @extent.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extent
      @extent = Extent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def extent_params
      params.require(:extent).permit(:code, :name)
    end
end
