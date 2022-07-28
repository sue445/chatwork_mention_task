class ApplicationController < ActionController::Base
  before_action :set_locale

  around_action :with_user_time_zone, if: :signed_in?

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

    def with_user_time_zone(&)
      Time.use_zone(current_user.time_zone, &)
    end

    def set_locale
      I18n.locale = current_user&.locale || compatible_locale
    end

    def compatible_locale
      http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
    end
end
