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

ActiveRecord::Schema.define(version: 20161119033016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "industry_id"
    t.boolean  "is_registered", default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "town_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.integer  "industry_id"
    t.integer  "company_id"
    t.date     "date"
    t.integer  "town_id"
    t.time     "datetime"
    t.integer  "location_id"
    t.string   "personal_responsible"
    t.string   "nature_of_review"
    t.text     "message"
    t.string   "account_details"
    t.string   "ticket_number"
    t.string   "review_type"
    t.integer  "user_id"
    t.string   "guest_token"
    t.string   "file"
    t.boolean  "archive",                 default: false
    t.boolean  "ispublished",             default: false
    t.datetime "published_date"
    t.datetime "change_date"
    t.text     "modified_review"
    t.boolean  "is_modified"
    t.text     "notes"
    t.boolean  "archive_attachment",      default: false
    t.boolean  "is_ticket_open",          default: true
    t.integer  "jagent_id"
    t.integer  "agent_id"
    t.integer  "old_jagent_id"
    t.integer  "last_published_agent_id"
    t.boolean  "admin_sagent_modified",   default: false
    t.string   "desired_outcome"
    t.integer  "old_agent_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "town"
    t.string   "city"
    t.string   "country"
    t.string   "title"
    t.string   "telephone_number"
    t.string   "mobile_number"
    t.string   "subscription"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "supplier_name"
    t.string   "supplier_vat_number"
    t.string   "industry"
    t.string   "authorised_responder"
    t.text     "notes"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "towns", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "unconfirmed_email"
    t.string   "secret_question"
    t.string   "answer"
    t.integer  "role_id",                default: 4
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "age"
    t.date     "dob"
    t.string   "country"
    t.string   "pobox"
    t.integer  "postal_code"
    t.string   "town"
    t.string   "lives_in"
    t.string   "avatar"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "role",                   default: "user"
    t.string   "preferred_alias"
    t.boolean  "accept_t_and_c",         default: false
    t.string   "guest_token"
    t.boolean  "is_subscribe"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
