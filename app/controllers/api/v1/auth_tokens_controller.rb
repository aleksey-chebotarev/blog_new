class Api::V1::AuthTokensController < Api::V1::BaseController
  include AuthHelper

  def create
    auth_token = authenticate_by_email

    if auth_token.present?
      render json: { success: true, auth_token: auth_token }, status: 201
    else
      raise Exceptions::NotAuthenticatedError
    end
  end

  private

  def authenticate_by_email
    user = User.find_by_email(params[:email])
    auth_token(user.id) if user.present? && user.valid_password?(params[:password])
  end
end
