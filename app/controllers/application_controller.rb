class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  # before_action :authenticate!
  include ExceptionHandler

  def authenticate!
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      begin
        decoded = JsonWebToken.decode(token)
        if decoded[:user_id]
          cache_key = "user_#{decoded[:user_id]}"
          @current_user = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
            User.find_by(id: decoded[:user_id])
          end
        end
      rescue JWT::ExpiredSignature, JWT::DecodeError => e
        render json: { error: e.message }, status: :unauthorized
        return
      end
    end

    unless @current_user
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  private

  def expired_signature(error)
    render json: { error: error.message }, status: :unauthorized
  end

  def decode_error(error)
    render json: { error: error.message }, status: :bad_request
  end
end
