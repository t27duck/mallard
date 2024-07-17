# frozen_string_literal: true

class AddRemoveTrackingParamsToFeeds < ActiveRecord::Migration[7.1]
  def change
    add_column :feeds, :remove_tracking_params, :boolean, null: false, default: true
  end
end
