class AuthToken
  def self.encode(payload, expiration = Rails.application.secrets.jwt_expiration_seconds.seconds.from_now)
    payload[:exp] = expiration.to_i
    JWT.encode(payload, Rails.application.secrets.jwt_key_base)
  end

  def self.decode(token)
    decoded = JWT.decode(token, Rails.application.secrets.jwt_key_base)
    HashWithIndifferentAccess.new(decoded[0])
  end
end
