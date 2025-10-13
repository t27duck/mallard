class AddEntryLimitToFeeds < ActiveRecord::Migration[8.1]
  def change
    add_column :feeds, :entry_limit, :integer, null: false, default: 0
  end
end
