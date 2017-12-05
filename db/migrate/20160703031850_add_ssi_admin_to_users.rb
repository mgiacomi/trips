class AddSsiAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ssi_admin, :boolean, default: false
  end
end
