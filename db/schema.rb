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

ActiveRecord::Schema.define(version: 20180120175109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotel_seats", force: :cascade do |t|
    t.string   "name"
    t.integer  "minimum_seats"
    t.integer  "maximum_seats"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "hotel_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "guest_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "booked_at"
    t.datetime "booking_day"
    t.datetime "booking_day_updated"
    t.integer  "guest_count_updated"
    t.integer  "guest_count"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "guest_id"
    t.integer  "hotel_id"
    t.integer  "hotel_seat_id"
  end

  create_table "working_shifts", force: :cascade do |t|
    t.string   "start_time"
    t.string   "end_time"
    t.string   "shift_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "hotel_id"
  end

  add_foreign_key "hotel_seats", "hotels"
  add_foreign_key "hotels", "guests"
  add_foreign_key "reservations", "guests"
  add_foreign_key "reservations", "hotel_seats"
  add_foreign_key "reservations", "hotels"
  add_foreign_key "working_shifts", "hotels"
end
