# frozen_string_literal: true

class Feed < ApplicationRecord
  has_many :entries, dependent: :delete_all

  validates :title, :url, presence: true

  def set_info
    return false if url.blank?
    return false unless feed_object.respond_to?(:title)

    self.title = feed_object.title
    true
  rescue StandardError
    false
  end

  def fetch
    return false if new_record?

    feed_object.entries.each do |entry|
      Entry.create_from_feedjira(id, entry)
    end

    update(last_checked: Time.now.utc)

    true
  end

  private

  def feed_object
    @feed_object ||= Feedjira::Feed.fetch_and_parse(url)
  end
end
