class CaseTypesController < ApplicationController
  before_action :set_case_type, only: %i[ show update destroy ]

  # GET /case_types
  # GET /case_types.json
  def index
    @case_types = CaseType.all
      render json: @case_types
  end

  # GET /case_types/1
  # GET /case_types/1.json
  def show
  end

  # POST /case_types
  # POST /case_types.json
  def create
    @case_type = CaseType.new(case_type_params)

    if @case_type.save
      render :show, status: :created, location: @case_type
    else
      render json: @case_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /case_types/1
  # PATCH/PUT /case_types/1.json
  def update
    if @case_type.update(case_type_params)
      render :show, status: :ok, location: @case_type
    else
      render json: @case_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /case_types/1
  # DELETE /case_types/1.json
  def destroy
    @case_type.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case_type
      @case_type = CaseType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def case_type_params
      params.require(:case_type).permit(:name, :code)
    end
end
