class GradsController < ApplicationController
  before_action :set_grad, only: %i[ show update destroy ]

  # GET /grads
  # GET /grads.json
  def index
    @grads = Grad.search(params)
    render json: @grads
  end

  # GET /grads/1
  # GET /grads/1.json
  def show
    render json: @grad
  end

  # POST /grads
  # POST /grads.json
  def create
    @grad = Grad.new(grad_params)

    if @grad.save
      render json: @grad
    else
      render json: @grad.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /grads/1
  # PATCH/PUT /grads/1.json
  def update
    if @grad.update(grad_params)
      render json: @grad
    else
      render json: @grad.errors, status: :unprocessable_entity
    end
  end

  # DELETE /grads/1
  # DELETE /grads/1.json
  def destroy
    @grad.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grad
      @grad = Grad.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def grad_params
      params.require(:grad).permit(:code, :name)
    end
end
