module ExceptionHandler
  extend ActiveSupport::Concern

  # กำหนดคลาสย่อยสำหรับจัดการข้อผิดพลาดต่างๆ
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  included do
    # จัดการข้อผิดพลาดที่เกิดขึ้น
    rescue_from ExceptionHandler::ExpiredSignature, with: :handle_expired_signature
    rescue_from ExceptionHandler::DecodeError, with: :handle_decode_error
  end

  private

  def handle_expired_signature(e)
    render json: { message: e.message }, status: :unauthorized
  end

  def handle_decode_error(e)
    render json: { message: e.message }, status: :unauthorized
  end
end