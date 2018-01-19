class AuthController < ApplicationController
  def callback
    redirect_to my_index_path
  end
end
