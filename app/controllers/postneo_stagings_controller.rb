class PostneoStagingsController < ApplicationController
  before_action :set_postneo_staging, only: %i[ show edit update destroy ]

  # GET /postneo_stagings
  # GET /postneo_stagings.json
  def index
    @postneo_stagings = PostneoStaging.all
    render json: @postneo_stagings
  end

  # GET /postneo_stagings/1
  # GET /postneo_stagings/1.json
  def show
    render json: @postneo_staging
  end

  # POST /postneo_stagings
  # POST /postneo_stagings.json
  def create
    @postneo_staging = PostneoStaging.new(postneo_staging_params)

    if @postneo_staging.save
      render :show, status: :created, location: @postneo_staging
    else
      render json: @postneo_staging.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /postneo_stagings/1
  # PATCH/PUT /postneo_stagings/1.json
  def update
    if @postneo_staging.update(postneo_staging_params)
      render :show, status: :ok, location: @postneo_staging
    else
      render json: @postneo_staging.errors, status: :unprocessable_entity
    end
  end

  # DELETE /postneo_stagings/1
  # DELETE /postneo_stagings/1.json
  def destroy
    @postneo_staging.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postneo_staging
      @postneo_staging = PostneoStaging.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def postneo_staging_params
      params.require(:postneo_staging).permit(:name, :code)
    end
end
