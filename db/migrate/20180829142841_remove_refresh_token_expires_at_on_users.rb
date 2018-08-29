class RemoveRefreshTokenExpiresAtOnUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :refresh_token_expires_at
  end

  def down
    add_column :users, :refresh_token_expires_at, :datetime, null: false
    add_index :users, :refresh_token_expires_at
  end
end
