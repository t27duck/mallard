# frozen_string_literal: true

class CleanUpEntries < ActiveRecord::Migration[6.0]
  def up
    rename_column :entries, :published, :published_at
    execute "UPDATE entries SET content = summary WHERE content IS NULL AND summary IS NOT NULL"
    remove_column :entries, :summary
    remove_index :entries, :feed_id
    change_column :entries, :guid, :string
    add_index :entries, %i[feed_id guid], unique: true
  end

  def down
    rename_column :entries, :published_at, :published
    add_column :entries, :summary, :text
    add_index :entries, :feed_id
    remove_index :entries, %i[feed_id guid]
    change_column :entries, :guid, :text
  end
end
