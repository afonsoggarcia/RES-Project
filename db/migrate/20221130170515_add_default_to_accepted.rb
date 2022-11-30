class AddDefaultToAccepted < ActiveRecord::Migration[7.0]
  def change
    change_column :articles, :accepted, :boolean, default: false
  end
end
