# frozen_string_literal: true

class Feed < ApplicationRecord
  ADDITIONAL_UNREAD_ENTRIES_TO_KEEP = 5
  has_many :entries, dependent: :delete_all

  validates :title, :url, presence: true

  scope :with_entry_count, lambda {
    select("feeds.*, (SELECT COUNT(1) FROM entries WHERE entries.feed_id = feeds.id) AS entry_count")
  }

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
    return false unless feed_object

    incoming_entries = feed_object.entries
    incoming_entries.each do |entry|
      Entry.create_from_feedjira(id, entry)
    end

    new_count = incoming_entries.size > entry_count_in_fetch ? incoming_entries.size : entry_count_in_fetch
    update(last_checked: Time.now.utc, entry_count_in_fetch: new_count)

    true
  end

  def clean
    return if entry_count_in_fetch.zero?

    entries.unstarred.read.where.not(
      id: Entry.where(feed_id: id).unstarred.read.order(published_at: :desc)
        .limit(entry_count_in_fetch + ADDITIONAL_UNREAD_ENTRIES_TO_KEEP)
    ).delete_all
  end

  def as_json(options = {})
    super.merge(last_checked: last_checked.strftime("%b %-d, %I:%M%p"))
  end

  private

  def feed_object
    @feed_object ||= begin
                       Feedjira::Feed.fetch_and_parse(url)
                     rescue StandardError
                       nil
                     end
  end
end
