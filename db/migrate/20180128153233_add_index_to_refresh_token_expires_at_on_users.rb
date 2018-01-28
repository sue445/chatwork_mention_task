class AddIndexToRefreshTokenExpiresAtOnUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :refresh_token_expires_at
  end
end
