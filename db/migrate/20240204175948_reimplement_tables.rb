# frozen_string_literal: true

class ReimplementTables < ActiveRecord::Migration[7.1]
  def change
    create_table :entries do |t|
      t.integer :feed_id, null: false
      t.string :title, null: false
      t.text :url, null: false
      t.string :guid, null: false
      t.string :author
      t.text :content
      t.datetime :published_at, precision: nil, null: false
      t.boolean :read, default: false, null: false
      t.boolean :starred, default: false, null: false
      t.index ["feed_id", "guid"], name: "index_entries_on_feed_id_and_guid", unique: true
    end

    create_table :feeds do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.boolean :sanitize, default: true, null: false
      t.datetime :last_checked, precision: nil
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.integer :entry_count_in_fetch, default: 0, null: false
    end

    create_table :users do |t|
      t.string :password_digest, null: false
      t.string :token, null: false
    end
  end
end
