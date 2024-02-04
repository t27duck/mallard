# frozen_string_literal: true

class RemoveSearchField < ActiveRecord::Migration[7.1]
  def up
    execute "DROP TRIGGER entries_tsvectorupdate ON entries"
    execute "DROP FUNCTION entries_weighted_search_trigger"
    remove_column :entries, :searchable
  end

  def down
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
  end
end
