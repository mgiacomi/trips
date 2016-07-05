class AddGradeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :grade, :integer, default: 0
  end
end
