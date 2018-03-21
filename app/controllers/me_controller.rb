class MeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  helper_method :translated_locale, :translated_available_locales

  def show
  end

  def edit
    @rooms = current_user.rooms
  end

  def update
    @user.update!(user_params)

    redirect_to me_path
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:room_id, :webhook_token, :account_type, :locale, :time_zone)
    end

    def translated_locale(locale)
      Global.translation.locales[locale]
    end

    def translated_available_locales
      I18n.available_locales.map {|locale| [locale, translated_locale(locale)] }.to_h
    end
end
