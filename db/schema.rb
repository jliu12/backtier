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

ActiveRecord::Schema.define(version: 20140505021513) do

  create_table "events", force: true do |t|
    t.string   "event_name"
    t.string   "location"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "date_time"
    t.string   "photo_url"
    t.string   "text"
    t.decimal  "location_lat"
    t.decimal  "location_long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "user_name"
    t.string   "user_real_name"
    t.string   "phone_number"
    t.decimal  "user_last_lat"
    t.decimal  "user_last_long"
    t.datetime "user_last_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
