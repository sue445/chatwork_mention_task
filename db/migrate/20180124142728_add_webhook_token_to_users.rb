class AddWebhookTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :webhook_token, :string
  end
end
