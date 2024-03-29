class CreateLois < ActiveRecord::Migration[6.1]
  def change
    create_table "lois", force: :cascade do |t|

      t.integer  "registration_id", limit: 4
      t.integer  "user_id",         limit: 4

      t.string   "p1name",          limit: 45
      t.string   "p1phone",         limit: 45
      t.string   "p1email",         limit: 45
      t.string   "p1address",       limit: 255
      t.string   "p1understand",    limit: 255
      t.string   "p1relationship",  limit: 255
      t.string   "p1signature",     limit: 45
      t.datetime "p1sigdate"

      t.string   "p2name",          limit: 45
      t.string   "p2phone",         limit: 45
      t.string   "p2email",         limit: 45
      t.string   "p2address",       limit: 255
      t.string   "p2understand",    limit: 255
      t.string   "p2relationship",  limit: 255
      t.string   "p2signature",     limit: 45
      t.datetime "p2sigdate"

      t.timestamps
    end

  end
end