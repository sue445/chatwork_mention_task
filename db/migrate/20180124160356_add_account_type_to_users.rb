class AddAccountTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_type, :integer, default: 0, null: false
  end
end
