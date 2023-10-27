# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  validates :title, :url, :published_at, :guid, presence: true
  validates :feed_id, uniqueness: { scope: :guid }

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }
  scope :starred, -> { where(starred: true) }
  scope :unstarred, -> { where(starred: false) }

  include PgSearch::Model
  pg_search_scope :search_entry,
                  against: { title: "A", content: "C" },
                  using: {
                    tsearch: {
                      dictionary: "english", tsvector_column: "searchable"
                    }
                  }

  def self.create_from_feedjira(feed_id, entry)
    identifier = entry.entry_id || entry.url
    return if Entry.exists?(feed_id: feed_id, guid: identifier)
    
    url = entry.url || entry.try(:enclusure_url)
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
        COUNT(1) FILTER (WHERE read = 'f') AS unread,
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
