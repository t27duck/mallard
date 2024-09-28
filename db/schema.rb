# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_07_16_234734) do
  create_table "entries", force: :cascade do |t|
    t.integer "feed_id", null: false
    t.string "title", null: false
    t.text "url", null: false
    t.string "guid", null: false
    t.string "author"
    t.text "content"
    t.datetime "published_at", precision: nil, null: false
    t.boolean "read", default: false, null: false
    t.boolean "starred", default: false, null: false
    t.index ["feed_id", "guid"], name: "index_entries_on_feed_id_and_guid", unique: true
  end

  create_table "feeds", force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.boolean "sanitize", default: true, null: false
    t.datetime "last_checked", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "entry_count_in_fetch", default: 0, null: false
    t.boolean "remove_tracking_params", default: true, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "password_digest", null: false
    t.string "token", null: false
  end

  # Virtual tables defined in this database.
  # Note that virtual tables may not work with other database engines. Be careful if changing database.
  create_virtual_table "entry_searches", "fts5", ["title", "content", "entry_id"]
end
