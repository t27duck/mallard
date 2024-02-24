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

ActiveRecord::Schema[7.1].define(version: 2024_02_23_231759) do
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
  end

# Could not dump table "fts_entries" because of following StandardError
#   Unknown type '' for column 'title'

# Could not dump table "fts_entries_config" because of following StandardError
#   Unknown type '' for column 'k'

# Could not dump table "fts_entries_content" because of following StandardError
#   Unknown type '' for column 'c0'

  create_table "fts_entries_data", force: :cascade do |t|
    t.binary "block"
  end

  create_table "fts_entries_docsize", force: :cascade do |t|
    t.binary "sz"
  end

# Could not dump table "fts_entries_idx" because of following StandardError
#   Unknown type '' for column 'segid'

  create_table "users", force: :cascade do |t|
    t.string "password_digest", null: false
    t.string "token", null: false
  end

end
