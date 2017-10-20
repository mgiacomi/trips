class AddChaperoneToRegistrations < ActiveRecord::Migration
  def change
    remove_column :parents, :chaperone
    add_column :registrations, :chaperone, :boolean, default: false
  end
end
