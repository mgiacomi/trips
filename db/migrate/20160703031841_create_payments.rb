class CreatePayments < ActiveRecord::Migration
  def change
    create_table "payments", force: :cascade do |t|
      t.integer  "registration_id",  limit: 4
      t.integer  "user_id",          limit: 4

      t.string   "pmtnum",           limit: 255
      t.datetime "pmtdate"
      t.decimal   "amount",          precision: 6, scale: 2, default: 0
      t.decimal   "fee",             precision: 6, scale: 2, default: 0

      t.timestamps
    end

  end
end
