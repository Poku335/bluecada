class CancerFormStatusesController < ApplicationController
  before_action :set_cancer_form_status, only: %i[ show update destroy ]

  # GET /cancer_form_statuses
  # GET /cancer_form_statuses.json
  def index
    @cancer_form_statuses = CancerFormStatus.all
  end

  # GET /cancer_form_statuses/1
  # GET /cancer_form_statuses/1.json
  def show
  end

  # POST /cancer_form_statuses
  # POST /cancer_form_statuses.json
  def create
    @cancer_form_status = CancerFormStatus.new(cancer_form_status_params)

    if @cancer_form_status.save
      render :show, status: :created, location: @cancer_form_status
    else
      render json: @cancer_form_status.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cancer_form_statuses/1
  # PATCH/PUT /cancer_form_statuses/1.json
  def update
    if @cancer_form_status.update(cancer_form_status_params)
      render :show, status: :ok, location: @cancer_form_status
    else
      render json: @cancer_form_status.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cancer_form_statuses/1
  # DELETE /cancer_form_statuses/1.json
  def destroy
    @cancer_form_status.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cancer_form_status
      @cancer_form_status = CancerFormStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cancer_form_status_params
      params.require(:cancer_form_status).permit(:name)
    end
end
