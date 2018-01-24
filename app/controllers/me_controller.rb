class MeController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user

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
      params.require(:user).permit(:room_id, :webhook_token, :account_type)
    end
end
