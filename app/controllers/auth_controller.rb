class AuthController < ApplicationController
  def callback
    user = User.register(auth_hash)
    session[:user_id] = user.id

    redirect_to me_path
  end

  def sign_out
    session.delete(:user_id)
    redirect_to root_path
  end

  def omniauth_failure
    redirect_to root_path, flash: { error: params[:error] }
  end

  private

    def auth_hash
      @auth_hash ||= request.env["omniauth.auth"]
    end
end
