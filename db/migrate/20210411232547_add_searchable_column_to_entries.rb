# frozen_string_literal: true

class AddSearchableColumnToEntries < ActiveRecord::Migration[6.1]
  def up
    add_column :entries, :searchable, :tsvector

    execute <<~SQL
    CREATE FUNCTION entries_weighted_search_trigger() RETURNS trigger AS $$
    begin
      new.searchable :=
        setweight(to_tsvector('pg_catalog.english', coalesce(new.title,'')), 'A') ||
        setweight(to_tsvector('pg_catalog.english', coalesce(new.content,'')), 'C');
      return new;
    end
    $$ LANGUAGE plpgsql;
    SQL

    execute <<~SQL
      CREATE TRIGGER entries_tsvectorupdate BEFORE INSERT OR UPDATE
      ON entries FOR EACH ROW EXECUTE FUNCTION entries_weighted_search_trigger();
    SQL

    update("UPDATE entries SET id=id")

    # If rails supported generated columns:
    # execute <<-SQL
    #   ALTER TABLE entries
    #   ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
    #     setweight(to_tsvector('english', coalesce(title, '')), 'A') ||
    #     setweight(to_tsvector('english', coalesce(content,'')), 'B')
    #   ) STORED;
    # SQL
  end

  def down
    remove_column :entries, :searchable
  end
end
