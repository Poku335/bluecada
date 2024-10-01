
class DiagnoseParagraphsController < ApplicationController
  before_action :set_diagnose_paragraph, only: %i[ show update destroy ]

  # GET /diagnose_paragraphs
  # GET /diagnose_paragraphs.json
  def index
    @diagnose_paragraphs = DiagnoseParagraph.search(params)
    render json: @diagnose_paragraphs
  end

  def import_diag
    @diagnose_paragraphs = DiagnoseParagraph.import_diag_paragraph(params)
    render json: @diagnose_paragraphs
  end

  # GET /diagnose_paragraphs/1
  # GET /diagnose_paragraphs/1.json
  def show
    render json: @diagnose_paragraph
  end

  # POST /diagnose_paragraphs
  # POST /diagnose_paragraphs.json
  def create
    @diagnose_paragraph = DiagnoseParagraph.new(diagnose_paragraph_params)

    if @diagnose_paragraph.save
      render :show, status: :created, location: @diagnose_paragraph
    else
      render json: @diagnose_paragraph.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /diagnose_paragraphs/1
  # PATCH/PUT /diagnose_paragraphs/1.json
  def update
    if @diagnose_paragraph.update(diagnose_paragraph_params)
      render :show, status: :ok, location: @diagnose_paragraph
    else
      render json: @diagnose_paragraph.errors, status: :unprocessable_entity
    end
  end

  # DELETE /diagnose_paragraphs/1
  # DELETE /diagnose_paragraphs/1.json
  def destroy
    @diagnose_paragraph.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagnose_paragraph
      @diagnose_paragraph = DiagnoseParagraph.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def diagnose_paragraph_params
      params.require(:diagnose_paragraph).permit(:diagnose_paragraph, :cancer_information_id, :diag_date)
    end
end
