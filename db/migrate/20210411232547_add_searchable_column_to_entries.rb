# frozen_string_literal: true

class AddSearchableColumnToEntries < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      ALTER TABLE entries
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('english', coalesce(title, '')), 'A') ||
        setweight(to_tsvector('english', coalesce(content,'')), 'B')
      ) STORED;
    SQL
  end

  def down
    remove_column :entries, :searchable
  end
end
