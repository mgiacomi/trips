class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table "registrations", force: :cascade do |t|
      t.integer  "user_id",              limit: 4
      t.integer  "parent_id",            limit: 4
      t.string   "gender_pronoun",       limit: 45
      t.string   "fname",                limit: 45
      t.string   "mname",                limit: 45
      t.string   "lname",                limit: 45
      t.string   "gender",               limit: 45
      t.integer  "grade",                limit: 4,   default: 0
      t.datetime "date_of_birth"
      t.decimal  "scholarship",          precision: 6, scale: 2, default: 0
      t.string   "ec_name",              limit: 45
      t.string   "ec_relationship",      limit: 45
      t.string   "ec_phone",             limit: 45
      t.string   "ec_address",           limit: 256
      t.string   "chaperone_parent",     limit: 48
      t.string   "refund_to",            limit: 48
      t.boolean  "withdrawn",            default: false

      t.timestamps
    end
  end
end
