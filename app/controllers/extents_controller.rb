class ExtentsController < ApplicationController
  before_action :set_extent, only: %i[ show update destroy ]

  # GET /extents
  # GET /extents.json
  def index
    @extents = Extent.all
    render json: @extents
  end

  # GET /extents/1
  # GET /extents/1.json
  def show
  end

  # POST /extents
  # POST /extents.json
  def create
    @extent = Extent.new(extent_params)

    if @extent.save
      render :show, status: :created, location: @extent
    else
      render json: @extent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /extents/1
  # PATCH/PUT /extents/1.json
  def update
    if @extent.update(extent_params)
      render :show, status: :ok, location: @extent
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
