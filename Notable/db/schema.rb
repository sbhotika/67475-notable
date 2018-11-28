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

ActiveRecord::Schema.define(version: 20181115185823) do

  create_table "notes", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "raw_notes", force: :cascade do |t|
    t.string   "raw_content"
    t.string   "attached_files"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "reminders", force: :cascade do |t|
    t.datetime "utc_time"
    t.text     "reminder_content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "review_chunks", force: :cascade do |t|
    t.integer  "starting_pt"
    t.integer  "ending_pt"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "task_definition"
    t.boolean  "is_completed"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_notes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "note_id"
    t.boolean  "is_favorite"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_reminders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reminder_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
