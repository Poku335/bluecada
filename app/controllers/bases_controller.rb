class BasesController < ApplicationController
  before_action :set_basis, only: %i[ show update destroy ]

  # GET /bases?p=1
  # GET /bases.json
  def index
    @bases = Basis.cached_basis
    render json: @bases
  end

  # GET /bases/1
  # GET /bases/1.json
  def show
    render json: @basis
  end

  # POST /bases
  # POST /bases.json
  def create
    @basis = Basis.new(basis_params)

    if @basis.save
      render :show, status: :created, location: @basis
    else
      render json: @basis.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bases/1
  # PATCH/PUT /bases/1.json
  def update
    if @basis.update(basis_params)
      render :show, status: :ok, location: @basis
    else
      render json: @basis.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bases/1
  # DELETE /bases/1.json
  def destroy
    @basis.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basis
      @basis = Basis.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def basis_params
      params.require(:basis).permit(:code, :name)
    end
end
