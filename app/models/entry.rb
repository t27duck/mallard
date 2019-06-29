# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  validates :feed, :title, :url, :published_at, :guid, presence: true
  validates :feed_id, uniqueness: { scope: :guid }

  scope :read, -> { where(read: true) }
  scope :starred, -> { where(starred: true) }
  scope :unread, -> { where(read: false) }
  scope :search_title, ->(term) { where(arel_table[:title].matches("%#{sanitize_sql_like(term)}%")) }

  def self.create_from_feedjira(feed_id, entry)
    identifier = entry.entry_id || entry.url
    return if Entry.exists?(feed_id: feed_id, guid: identifier)

    title = entry.title.presence || entry.url
    Entry.create!(
      feed_id: feed_id,
      title: title,
      url: entry.url,
      author: entry.author,
      published_at: entry.published,
      guid: identifier,
      content: entry.content || entry.summary
    )
  end

  def self.stats
    data = ApplicationRecord.connection.execute(<<~SQL).pluck("unread", "starred").first
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

  def minimum_hash
    slice(:id, :title)
  end
end
