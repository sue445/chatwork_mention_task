class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :account_id
      t.integer :room_id
      t.string :access_token
      t.string :refresh_token
      t.datetime :access_token_expires_at
      t.datetime :refresh_token_expires_at
      t.datetime :refresh_token_reminded_at

      t.timestamps
    end
  end
end
