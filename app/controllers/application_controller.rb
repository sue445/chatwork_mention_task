class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale

  helper_method :current_user, :signed_in?

  private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def signed_in?
      !!current_user
    end

    def authenticate_user!
      redirect_to root_path unless signed_in?
    end
end
