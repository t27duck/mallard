# frozen_string_literal: true

class Feed < ApplicationRecord
  has_many :entries, dependent: :delete_all

  validates :title, :url, presence: true

  def feed_object
    @feed_object ||= Feedjira::Feed.fetch_and_parse(url)
  end

  def set_info
    return false if url.blank?

    if feed_object.respond_to?(:title)
      self.title = feed_object.title
      self.etag = feed_object.etag
      self.last_modified = feed_object.last_modified
      true
    else
      false
    end
  rescue StandardError
    false
  end

  def fetch; end
end
