class TumurMarkersController < ApplicationController
    before_action :set_tumur_marker, only: %i[show update destroy]
  
    # GET /tumur_markers
    def index
      @tumur_markers = TumurMarker.all
      render json: @tumur_markers
    end
  
    # GET /tumur_markers/:id
    def show
      render json: @tumur_marker
    end
  
    # POST /tumur_markers
    def create
      @tumur_marker = TumurMarker.new(tumur_marker_params)
      if @tumur_marker.save
        render json: @tumur_marker, status: :created
      else
        render json: @tumur_marker.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /tumur_markers/:id
    def update
      if @tumur_marker.update(tumur_marker_params)
        render json: @tumur_marker
      else
        render json: @tumur_marker.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /tumur_markers/:id
    def destroy
      @tumur_marker.destroy
      render json: { message: "Tumur Marker deleted successfully" }
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_tumur_marker
      @tumur_marker = TumurMarker.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def tumur_marker_params
      params.require(:tumur_marker).permit(:name, :description, :type, :value)
    end
  end
  