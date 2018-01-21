class MyController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def edit
    @rooms = current_user.rooms
  end

  def update
    current_user.room_id = params[:room_id]
    current_user.save!

    redirect_to my_index_path
  end
end
