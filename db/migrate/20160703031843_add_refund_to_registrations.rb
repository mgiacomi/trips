class AddRefundToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :refund_to, :string, limit: 48
  end
end
