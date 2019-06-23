# frozen_string_literal: true

class CleanupFeeds < ActiveRecord::Migration[6.0]
  def up
    remove_column :feeds, :etag
    remove_column :feeds, :last_modified
  end

  def down
    add_column :feeds, :last_modified, :datetime
    add_column :feeds, :etag, :string
  end
end
