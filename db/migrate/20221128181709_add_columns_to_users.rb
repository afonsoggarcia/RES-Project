class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :admin, :boolean
    add_column :users, :believer, :boolean
    add_column :users, :publisher, :boolean
    add_column :users, :description, :string
  end
end
