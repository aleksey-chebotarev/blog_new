module AuthHelper
  def auth_token(user_id)
    AuthToken.encode({ user_id: user_id })
  end
end
