class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table "registrations", force: :cascade do |t|
      t.integer  "user_id",             limit: 4
      t.datetime "created_at"
      t.datetime "updated_at"

      t.string "sfname",                limit: 45
      t.string "slname",                limit: 45
      t.string "sgender",               limit: 45
      t.integer  "grade",               limit: 4,   default: 0

      t.string "p1fname",               limit: 45
      t.string "p1lname",               limit: 45
      t.string "p1phone",               limit: 45
      t.string "p1email",               limit: 45

      t.string "p2fname",               limit: 45
      t.string "p2lname",               limit: 45
      t.string "p2phone",               limit: 45
      t.string "p2email",               limit: 45

      t.string "street",                limit: 255
      t.string "city",                  limit: 45
      t.string "state",                 limit: 45
      t.string "zip",                   limit: 45

      t.decimal   "scholarship",        precision: 6, scale: 2, default: 0
    end

    create_table "payments", force: :cascade do |t|
      t.integer  "registration_id",    limit: 4
      t.integer  "user_id",    limit: 4
      t.string   "pmtnum",       limit: 255
      t.string   "pmtdate",      limit: 255
      t.string   "amount",       limit: 255
      t.datetime "receipt_date"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end
end
