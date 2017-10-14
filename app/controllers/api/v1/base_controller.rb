class Api::V1::BaseController < ActionController::Base
  respond_to :json

  rescue_from Exceptions::NotAuthenticatedError, with: :user_not_authenticated
  rescue_from Exceptions::AuthenticationTimeoutError, with: :authentication_timeout

  protected

  def authenticate_request!
    raise Exceptions::NotAuthenticatedError unless user_id_included_in_auth_token?

    @current_user = User.find(decoded_auth_token[:user_id])
  rescue JWT::ExpiredSignature
    raise Exceptions::AuthenticationTimeoutError
  rescue JWT::VerificationError, JWT::DecodeError
    raise Exceptions::NotAuthenticatedError
  end

  private

  def user_id_included_in_auth_token?
    http_auth_token && decoded_auth_token && decoded_auth_token[:user_id]
  end

  def decoded_auth_token
    @decoded_auth_token ||= AuthToken.decode(http_auth_token)
  end

  def http_auth_token
    @http_auth_token ||= if request.headers['X-Auth-Token'].present?
                           request.headers['X-Auth-Token'].split(' ').last
                         end
  end

  def render_error(text, status_code=422)
    render json: { error: { message: text } },
           status: status_code
  end

  def render_success(data, status_code=200)
    render json: { data: data },
           status: status_code
  end

  def user_not_authenticated
    render_error 'Not Authenticated', 401
  end

  def authentication_timeout
    render_error 'Authentication Timeout', 419
  end
end
