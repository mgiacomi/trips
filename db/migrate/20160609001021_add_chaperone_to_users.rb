class AddChaperoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :chaperone, :boolean, default: false
  end
end
