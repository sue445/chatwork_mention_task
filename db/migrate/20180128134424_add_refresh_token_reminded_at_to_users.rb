class AddRefreshTokenRemindedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :refresh_token_reminded_at, :datetime
  end
end
