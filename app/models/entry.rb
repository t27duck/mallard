# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  validates :title, :url, :published_at, :guid, presence: true
  validates :feed_id, uniqueness: { scope: :guid }

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }
  scope :starred, -> { where(starred: true) }
  scope :unstarred, -> { where(starred: false) }
  scope :search_entry, ->(term) { where("LOWER(title) LIKE ?", "%#{term}%") }

  def self.create_from_feedjira(feed_id, entry)
    url = entry.url || entry.try(:enclosure_url)
    identifier = entry.entry_id || url
    return if Entry.exists?(feed_id: feed_id, guid: identifier)
    return if url.blank? || entry.published.blank?

    Entry.create!(
      feed_id: feed_id,
      title: entry.title.presence || url,
      url: url,
      author: entry.author,
      published_at: entry.published,
      guid: identifier,
      content: entry.content || entry.summary || "No content for entry. Visit URL."
    )
  end

  def self.stats
    data = ApplicationRecord.connection.execute(<<~SQL.squish).pick("unread", "starred")
      SELECT
        COUNT(1) FILTER (WHERE NOT read) AS unread,
        COUNT(1) FILTER (WHERE starred) AS starred
      FROM entries
    SQL
    {
      total_unread: data[0],
      total_starred: data[1]
    }
  end

  def santitized_content
    feed.sanitize? ? ActionController::Base.helpers.sanitize(content) : content
  end
end
