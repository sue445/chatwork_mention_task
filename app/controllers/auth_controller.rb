class AuthController < ApplicationController
  def callback
    user = User.find_or_initialize_by(account_id: auth_hash[:uid]) do |u|
      u.room_id = auth_hash[:extra][:raw_info][:room_id]
      u.refresh_token_expires_at = User::REFRESH_TOKEN_EXPIRES_IN.from_now
    end
    user.name                    = auth_hash[:info][:name]
    user.avatar_image_url        = auth_hash[:info][:image]
    user.access_token            = auth_hash[:credentials][:token]
    user.refresh_token           = auth_hash[:credentials][:refresh_token]
    user.access_token_expires_at = auth_hash[:credentials][:expires_at].seconds.from_now

    user.save!

    session[:user_id] = user.id

    redirect_to my_index_path
  end

  def sign_out
    session.delete(:user_id)
    redirect_to root_path
  end

  private

    def auth_hash
      @auth_hash ||= request.env["omniauth.auth"]
    end
end
