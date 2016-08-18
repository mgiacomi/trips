class AddFeeToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :fee, :integer, default: 0
  end
end
