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

ActiveRecord::Schema.define(version: 20140812182009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "inspections", force: true do |t|
    t.string   "inspection_date"
    t.string   "action"
    t.string   "violation_code"
    t.string   "score"
    t.string   "current_grade"
    t.string   "grade_date"
    t.string   "record_date"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
  end

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "boro"
    t.string   "building"
    t.string   "street"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "cuisine_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "cord1"
    t.float    "cord2"
  end

  add_index "restaurants", ["zipcode", "name"], name: "index_restaurants_on_zipcode_and_name", using: :btree

end
