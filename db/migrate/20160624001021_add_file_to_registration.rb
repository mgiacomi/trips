class AddFileToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :file_name, :string
    add_column :registrations, :file_ext, :string
  end
end
