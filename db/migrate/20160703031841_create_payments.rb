class CreatePayments < ActiveRecord::Migration
  def change
    create_table "payments", force: :cascade do |t|
      t.integer  "registration_id",    limit: 4
      t.integer  "user_id",    limit: 4
      t.string   "pmtnum",       limit: 255
      t.datetime "pmtdate"
      t.string   "amount",       limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end
end
