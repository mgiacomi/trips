class AddChaperoneToParents < ActiveRecord::Migration[6.1]
  def change
    remove_column :registrations, :chaperone
    add_column :parents, :chaperone, :boolean, default: false
  end
end
