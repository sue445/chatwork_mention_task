class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer  :account_id,               null: false
      t.integer  :room_id,                  null: false
      t.string   :name,                     null: false
      t.string   :avatar_image_url,         null: false
      t.string   :access_token,             null: false
      t.string   :refresh_token,            null: false
      t.datetime :access_token_expires_at,  null: false
      t.datetime :refresh_token_expires_at, null: false

      t.timestamps
    end

    add_index :users, :account_id, unique: true
  end
end
