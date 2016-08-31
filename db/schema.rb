# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160703031841) do

  create_table "payments", force: :cascade do |t|
    t.integer  "registration_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.string   "pmtnum",          limit: 255
    t.datetime "pmtdate"
    t.decimal  "amount",                      precision: 6, scale: 2, default: 0.0
    t.decimal  "fee",                         precision: 6, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "sfname",      limit: 45
    t.string   "slname",      limit: 45
    t.string   "sgender",     limit: 45
    t.integer  "grade",       limit: 4,                           default: 0
    t.string   "p1fname",     limit: 45
    t.string   "p1lname",     limit: 45
    t.string   "p1phone",     limit: 45
    t.string   "p1email",     limit: 45
    t.string   "p2fname",     limit: 45
    t.string   "p2lname",     limit: 45
    t.string   "p2phone",     limit: 45
    t.string   "p2email",     limit: 45
    t.string   "street",      limit: 255
    t.string   "city",        limit: 45
    t.string   "state",       limit: 45
    t.string   "zip",         limit: 45
    t.string   "file_name",   limit: 56
    t.string   "file_ext",    limit: 56
    t.boolean  "onk",                                             default: false
    t.decimal  "scholarship",             precision: 6, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "admin",                              default: false
    t.boolean  "chaperone",                          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
