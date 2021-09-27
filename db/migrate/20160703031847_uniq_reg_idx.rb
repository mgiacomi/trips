class UniqRegIdx < ActiveRecord::Migration[6.1]
  def up
    execute "CREATE UNIQUE INDEX index_reg_lcase_first_last ON registrations USING btree (lower(fname), lower(lname));"
  end

  def down
    execute "DROP INDEX index_reg_lcase_first_last;"
  end
end