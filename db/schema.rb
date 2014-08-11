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

ActiveRecord::Schema.define(version: 20140811013509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "config_infos", force: true do |t|
    t.string "key",   null: false
    t.string "value", null: false
  end

  add_index "config_infos", ["key"], name: "index_config_infos_on_key", unique: true, using: :btree

  create_table "entries", force: true do |t|
    t.integer  "feed_id",                   null: false
    t.string   "title",                     null: false
    t.text     "url",                       null: false
    t.text     "guid",                      null: false
    t.string   "author"
    t.text     "summary"
    t.text     "content"
    t.datetime "published",                 null: false
    t.boolean  "read",      default: false, null: false
    t.boolean  "starred",   default: false, null: false
  end

  add_index "entries", ["feed_id"], name: "index_entries_on_feed_id", using: :btree

  create_table "feeds", force: true do |t|
    t.string   "title",                        null: false
    t.string   "url",                          null: false
    t.string   "etag",                         null: false
    t.boolean  "sanitize",      default: true, null: false
    t.datetime "last_checked"
    t.datetime "last_modified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
