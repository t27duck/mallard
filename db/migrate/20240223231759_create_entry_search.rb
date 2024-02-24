# frozen_string_literal: true

class CreateEntrySearch < ActiveRecord::Migration[7.1]
  def up
    execute("CREATE VIRTUAL TABLE entry_searches USING fts5(title, content, entry_id)")
  end

  def down
    execute("DROP TABLE IF EXISTS entry_searches")
  end
end
