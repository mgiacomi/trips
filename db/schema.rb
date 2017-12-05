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

ActiveRecord::Schema.define(version: 20160703031850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lois", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "registration_id"
    t.integer  "user_id"
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
  end

  create_table "parents", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "p1fname",    limit: 45
    t.string   "p1lname",    limit: 45
    t.string   "p1phone",    limit: 45
    t.string   "p1email",    limit: 45
    t.string   "p1street",   limit: 255
    t.string   "p1city",     limit: 45
    t.string   "p1state",    limit: 45
    t.string   "p1zip",      limit: 45
    t.string   "p2fname",    limit: 45
    t.string   "p2lname",    limit: 45
    t.string   "p2phone",    limit: 45
    t.string   "p2email",    limit: 45
    t.string   "p2street",   limit: 255
    t.string   "p2city",     limit: 45
    t.string   "p2state",    limit: 45
    t.string   "p2zip",      limit: 45
    t.boolean  "onk",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "registration_id"
    t.integer  "user_id"
    t.string   "pmtnum",          limit: 255
    t.datetime "pmtdate"
    t.decimal  "amount",                      precision: 6, scale: 2, default: 0.0
    t.decimal  "fee",                         precision: 6, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "gender_pronoun",  limit: 45
    t.string   "fname",           limit: 45
    t.string   "mname",           limit: 45
    t.string   "lname",           limit: 45
    t.string   "gender",          limit: 45
    t.integer  "grade",                                               default: 0
    t.datetime "date_of_birth"
    t.decimal  "scholarship",                 precision: 6, scale: 2, default: 0.0
    t.string   "ec_name",         limit: 45
    t.string   "ec_relationship", limit: 45
    t.string   "ec_phone",        limit: 45
    t.string   "ec_address",      limit: 256
    t.string   "refund_to",       limit: 48
    t.boolean  "withdrawn",                                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "chaperone",                                           default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.boolean  "ssi_admin",              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
