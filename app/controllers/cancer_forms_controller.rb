class CancerFormsController < ApplicationController
  before_action :set_cancer_form, only: %i[ show update destroy ]

  # GET /cancer_forms
  # GET /cancer_forms.json
  def index
    @cancer_forms = CancerForm.all
    render json: @cancer_forms
  end

  # GET /cancer_forms/1
  # GET /cancer_forms/1.json
  def show
    # cancer_form = CancerForm.includes(:current_user).find(params[:id])
    #   render json: cancer_form
    render json: @cancer_form
  end

  def check_editing
    @cancer_form = CancerForm.check_editing(params)
    render json: @cancer_form
  end

  def change_editing_status
    @cancer_form = CancerForm.change_editing_status(params[:cancer_form_id])
    render json: @cancer_form
  end

  # POST /cancer_forms
  # POST /cancer_forms.json
  def create
    @cancer_form = CancerForm.new(cancer_form_params)
    @cancer_form = @cancer_form.create_form_data
    if @cancer_form.save
      render json: @cancer_form, status: :created, location: @cancer_form
    else
      render json: @cancer_form.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cancer_forms/1
  # PATCH/PUT /cancer_forms/1.json
  def update
    @cancer_form = CancerForm.find(params[:id])
    if @cancer_form.update(cancer_form_params)
      render json: @cancer_form, status: :ok
    else
      render json: @cancer_form.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cancer_forms/1
  # DELETE /cancer_forms/1.json
  def destroy
    @cancer_form.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cancer_form
      @cancer_form = CancerForm.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def cancer_form_params
      params.require(:cancer_form).permit(:primary, :is_editing, :current_user_id, :treatment_follow_up_id, 
                                          :information_diagnose_id, :treatment_information_id, :cancer_information_id, 
                                          :patient_id, :cancer_form_status_id, :additional_field_jsonb, :tumor_id)
    end
end
