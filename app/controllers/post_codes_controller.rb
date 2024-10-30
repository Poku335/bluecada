class PostCodesController < ApplicationController
  before_action :set_post_code, only: %i[ show update destroy ]

  # GET /post_codes
  # GET /post_codes.json
  def index
    @post_code = PostCode.get_post_code(params)
    render json: @post_code
  end

  # GET /post_codes/1
  # GET /post_codes/1.json
  def show
    render json: @post_code
  end

  # POST /post_codes
  # POST /post_codes.json
  def create
    @post_code = PostCode.new(post_code_params)

    if @post_code.save
      render :show, status: :created, location: @post_code
    else
      render json: @post_code.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /post_codes/1
  # PATCH/PUT /post_codes/1.json
  def update
    if @post_code.update(post_code_params)
      render :show, status: :ok, location: @post_code
    else
      render json: @post_code.errors, status: :unprocessable_entity
    end
  end

  # DELETE /post_codes/1
  # DELETE /post_codes/1.json
  def destroy
    @post_code.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_code
      @post_code = PostCode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_code_params
      params.require(:post_code).permit(:code, :province, :district, :sub_district)
    end
end
