class AddChaperoneToParents < ActiveRecord::Migration
  def change
    remove_column :registrations, :chaperone
    add_column :parents, :chaperone, :boolean, default: false
  end
end
