# frozen_string_literal: true

class Entry < ApplicationRecord
  SEARCHABLE_ATTRIBUTES = [:title, :content].freeze
  belongs_to :feed

  validates :title, :url, :published_at, :guid, presence: true
  validates :feed_id, uniqueness: { scope: :guid }

  after_save_commit :update_search_index
  after_destroy_commit :delete_search_index

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }
  scope :starred, -> { where(starred: true) }
  scope :unstarred, -> { where(starred: false) }
  scope :full_search, lambda { |query|
    query = query.gsub(/[^\dA-Za-z ]/, "")

    return none if query.blank?

    search_table = EntrySearch.quoted_table_name

    joins("JOIN #{search_table} ON #{search_table}.entry_id = #{quoted_table_name}.id")
      .where(sanitize_sql_array(["#{search_table} = :query", { query: query }])).order(:rank)
  }

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

  def self.reindex(*ids)
    target_ids = Array(ids)
    target_ids = self.ids if target_ids.empty?

    EntrySearch.where(entry_id: target_ids).delete_all

    target_ids.each do |id|
      record = select(*SEARCHABLE_ATTRIBUTES).find_by(id: id)

      next if record.blank?

      attrs = SEARCHABLE_ATTRIBUTES.index_with do |attr|
        Nokogiri::HTML(record[attr.to_sym]).text.gsub(/[^\dA-Za-z ]/, "") || ""
      end
      attrs[:entry_id] = id

      EntrySearch.create(attrs)
    end
  end

  def santitized_content
    feed.sanitize? ? ActionController::Base.helpers.sanitize(content) : content
  end

  def final_url
    return url unless feed.remove_tracking_params?

    uri = URI.parse(url)
    return url unless uri.query

    clean_key_vals = URI.decode_www_form(uri.query).reject { |k, _| k.start_with?("utm_") }
    uri.query = URI.encode_www_form(clean_key_vals)
    uri.to_s
  end

  private

  def update_search_index
    return unless SEARCHABLE_ATTRIBUTES.any? { |attr| public_send(:"#{attr}_previously_changed?") }

    attrs = SEARCHABLE_ATTRIBUTES.index_with do |attr|
      Nokogiri::HTML(public_send(attr)).text.gsub(/[^\dA-Za-z ]/, "") || ""
    end
    attrs[:entry_id] = id

    delete_search_index
    EntrySearch.create(attrs)
  end

  def delete_search_index
    EntrySearch.where(entry_id: id).delete_all
  end
end
