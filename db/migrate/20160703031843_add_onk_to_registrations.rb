class AddOnkToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :onk, :boolean, default: false
  end
end
