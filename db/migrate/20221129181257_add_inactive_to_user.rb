class AddInactiveToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :inactive?, :boolean, default: false
  end
end
