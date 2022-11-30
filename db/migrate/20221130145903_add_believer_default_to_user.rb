class AddBelieverDefaultToUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :believer, :boolean, default: false
  end
end
