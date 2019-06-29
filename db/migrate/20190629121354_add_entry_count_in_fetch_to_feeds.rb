# frozen_string_literal: true

class AddEntryCountInFetchToFeeds < ActiveRecord::Migration[6.0]
  def change
    add_column :feeds, :entry_count_in_fetch, :integer, null: false, default: 0
  end
end
