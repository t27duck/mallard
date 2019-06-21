# frozen_string_literal: trueyy

class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.integer :feed_id, null: false
      t.string :title, null: false
      t.text :url, null: false
      t.text :guid, null: false
      t.string :author
      t.text :summary
      t.text :content
      t.datetime :published, null: false
      t.boolean :read, null: false, default: false
      t.boolean :starred, null: false, default: false
    end

    add_index :entries, :feed_id
  end
end
