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

ActiveRecord::Schema.define(version: 20140515025149) do

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.string   "event_name"
    t.string   "location"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_messages", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "message_id"
  end

  add_index "events_messages", ["event_id", "message_id"], name: "index_events_messages_on_event_id_and_message_id"

  create_table "friendships", force: true do |t|
    t.integer  "friender_id"
    t.integer  "friendee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.integer  "user_sent"
    t.integer  "user_invited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "date_time"
    t.string   "photo_url"
    t.string   "text"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "date_time"
    t.string   "photo_url"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "user_name"
    t.string   "user_name_clean"
    t.string   "user_real_name"
    t.string   "phone_number"
    t.decimal  "user_last_lat"
    t.decimal  "user_last_long"
    t.datetime "user_last_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "salt"
  end

  create_table "users_events", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  add_index "users_events", ["user_id", "event_id"], name: "index_users_events_on_user_id_and_event_id"

  create_table "users_invitations", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "invitation_id"
  end

  add_index "users_invitations", ["user_id", "invitation_id"], name: "index_users_invitations_on_user_id_and_invitation_id"

end
