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

ActiveRecord::Schema.define(version: 20130818005608) do

  create_table "activities", force: true do |t|
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_type_id"
    t.integer  "user_id"
  end

  add_index "activities", ["activity_type_id"], name: "index_activities_on_activity_type_id"
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "activity_types", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "username"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_exercise_token"
    t.boolean  "receive_email_notification"
  end

end
