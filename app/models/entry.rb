# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  validates :feed, :title, :url, :published_at, :guid, presence: true
  validates :feed_id, uniqueness: { scope: :guid }

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }
  scope :starred, -> { where(starred: true) }
  scope :unstarred, -> { where(starred: false) }
  scope :search_title, ->(term) { where(arel_table[:title].matches("%#{sanitize_sql_like(term)}%")) }

  def self.create_from_feedjira(feed_id, entry)
    identifier = entry.entry_id || entry.url
    return if Entry.exists?(feed_id: feed_id, guid: identifier)
    return if entry.url.blank? || entry.published.blank?

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

  def minimum_hash
    slice(:id, :title)
  end

  def as_json(options = {})
    prepared_content = feed.sanitize? ? ActionController::Base.helpers.sanitize(content) : content
    super.merge(published_at: published_at.strftime("%b %-d, %I:%M%p"), content: prepared_content)
  end
end
