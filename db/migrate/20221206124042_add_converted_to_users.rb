class AddConvertedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :converted, :boolean, default: false
  end
end
