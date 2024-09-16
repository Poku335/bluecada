class ReligionsController < ApplicationController
  before_action :set_religion, only: %i[ show update destroy ]

  # GET /religions
  # GET /religions.json
  def index
    @religions = Religion.all
    render json: @religions
  end

  # GET /religions/1
  # GET /religions/1.json
  def show
  end

  # POST /religions
  # POST /religions.json
  def create
    @religion = Religion.new(religion_params)

    if @religion.save
      render :show, status: :created, location: @religion
    else
      render json: @religion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /religions/1
  # PATCH/PUT /religions/1.json
  def update
    if @religion.update(religion_params)
      render :show, status: :ok, location: @religion
    else
      render json: @religion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /religions/1
  # DELETE /religions/1.json
  def destroy
    @religion.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_religion
      @religion = Religion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def religion_params
      params.require(:religion).permit(:code, :name)
    end
end
