class CreateParents < ActiveRecord::Migration[6.1]
  def change
    create_table "parents", force: :cascade do |t|
      t.integer  "user_id"
      t.string   "p1fname",     limit: 45
      t.string   "p1lname",     limit: 45
      t.string   "p1phone",     limit: 45
      t.string   "p1email",     limit: 45
      t.string   "p1street",    limit: 255
      t.string   "p1city",      limit: 45
      t.string   "p1state",     limit: 45
      t.string   "p1zip",       limit: 45
      t.string   "p2fname",     limit: 45
      t.string   "p2lname",     limit: 45
      t.string   "p2phone",     limit: 45
      t.string   "p2email",     limit: 45
      t.string   "p2street",    limit: 255
      t.string   "p2city",      limit: 45
      t.string   "p2state",     limit: 45
      t.string   "p2zip",       limit: 45
      t.boolean  "onk",         default: false

      t.timestamps
    end
  end
end
