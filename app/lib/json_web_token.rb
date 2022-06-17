module JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  module_function

  def encode(payload)
    payload[:exp] = 1.day.seconds.from_now.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode(token, verify_expiration: true)
    decoded = JWT.decode(token, SECRET_KEY, true, { verify_expiration: verify_expiration, algorithm: 'HS256' })[0]
    HashWithIndifferentAccess.new decoded
  end
end
