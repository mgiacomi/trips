class AddAddressToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :street2, :string, limit: 255
    add_column :registrations, :city2,   :string, limit: 45
    add_column :registrations, :state2,  :string, limit: 45
    add_column :registrations, :zip2,    :string, limit: 45
  end
end
