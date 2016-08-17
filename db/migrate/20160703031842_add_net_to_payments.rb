class AddNetToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :net, :integer, default: 0
  end
end
