class AddSsiAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :ssi_admin, :boolean, default: false
  end
end
