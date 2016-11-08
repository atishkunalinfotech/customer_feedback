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

ActiveRecord::Schema.define(version: 20161108210939) do

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

end
