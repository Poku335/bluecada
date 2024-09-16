require 'jwt'

class JsonWebToken
  class << self
    # Method สำหรับ encode payload เป็น JWT
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i  # ตั้งค่าเวลาหมดอายุของ JWT
      JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')  # encode ด้วย algorithm HS256 และ secret_key_base ของ Rails
    end

    # Method สำหรับ decode JWT เป็น payload
    def decode(token)
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')[0]  # decode โดยใช้ secret_key_base และต้องระบุ algorithm เป็น 'HS256'
      HashWithIndifferentAccess.new(decoded)  # ส่งผลลัพธ์เป็น HashWithIndifferentAccess
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
      raise ExceptionHandler::ExpiredSignature, e.message  # จัดการ error ExpiredSignature
    rescue JWT::DecodeError, JWT::VerificationError => e
      raise ExceptionHandler::DecodeError, e.message  # จัดการ error DecodeError
    end
  end
end