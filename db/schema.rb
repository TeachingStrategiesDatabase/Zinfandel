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

ActiveRecord::Schema.define(version: 20141108032550) do

  create_table "departments", force: true do |t|
    t.string "name"
  end

  create_table "keywords", force: true do |t|
    t.string  "keyword"
    t.integer "strategy_id"
  end

  create_table "strategies", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "tech"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "keywords",   default: ""
    t.string   "department", default: ""
    t.string   "subject",    default: ""
  end

  create_table "subjects", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_hash"
    t.boolean  "admin",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_token"
  end

end
