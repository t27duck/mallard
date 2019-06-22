# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_22_145835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "config_infos", force: :cascade do |t|
    t.string "key", null: false
    t.string "value", null: false
    t.index ["key"], name: "index_config_infos_on_key", unique: true
  end

  create_table "entries", force: :cascade do |t|
    t.integer "feed_id", null: false
    t.string "title", null: false
    t.text "url", null: false
    t.text "guid", null: false
    t.string "author"
    t.text "summary"
    t.text "content"
    t.datetime "published", null: false
    t.boolean "read", default: false, null: false
    t.boolean "starred", default: false, null: false
    t.index ["feed_id"], name: "index_entries_on_feed_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.string "etag"
    t.boolean "sanitize", default: true, null: false
    t.datetime "last_checked"
    t.datetime "last_modified"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "user", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
