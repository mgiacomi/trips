class AddChaperoneToRegistrations < ActiveRecord::Migration[6.1]
  def change
    remove_column :parents, :chaperone
    add_column :registrations, :chaperone, :boolean, default: false
  end
end
