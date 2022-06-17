class AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def login
    user = User.find_by_email(login_params[:email])
    return head :unauthorized unless user&.authenticate(login_params[:password])

    render_json({ token: JsonWebToken.encode(sub: user.id) })
  end

  def register
    user = User.create!(register_params)
    render_json user, status: :created
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def register_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
