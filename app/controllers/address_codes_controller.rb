class AddressCodesController < ApplicationController
  before_action :set_address_code, only: %i[ show update destroy ]

  # GET /address_codes
  # GET /address_codes.json
  def index
    @address_codes = AddressCode.all
    render json: @address_codes
  end

  # GET /address_codes/1
  # GET /address_codes/1.json
  def show
    render json: @address_code
  end

  # POST /address_codes
  # POST /address_codes.json
  def create
    @address_code = AddressCode.new(address_code_params)

    if @address_code.save
      render :show, status: :created, location: @address_code
    else
      render json: @address_code.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /address_codes/1
  # PATCH/PUT /address_codes/1.json
  def update
    if @address_code.update(address_code_params)
      render :show, status: :ok, location: @address_code
    else
      render json: @address_code.errors, status: :unprocessable_entity
    end
  end

  # DELETE /address_codes/1
  # DELETE /address_codes/1.json
  def destroy
    @address_code.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address_code
      @address_code = AddressCode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_code_params
      params.require(:address_code).permit(:code, :province, :district, :sub_district)
    end
end
