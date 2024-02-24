# frozen_string_literal: true

class CreateEntrySearch < ActiveRecord::Migration[7.1]
  def up
    execute("CREATE VIRTUAL TABLE fts_entries USING fts5(title, content, entry_id)")
  end

  def down
    execute("DROP TABLE IF EXISTS fts_entries")
  end
end
