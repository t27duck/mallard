class Entry < ActiveRecord::Base
  belongs_to :feed

  validates_presence_of :feed, :title, :url, :published, :guid

  def self.create_from_feedjira(feed_id, entry)
    identifier = determine_identifier(entry)
    title = entry.title.presence || entry.url
    Entry.create!({
      :feed_id   => feed_id,
      :title     => title,
      :url       => entry.url,
      :author    => entry.author,
      :published => entry.published,
      :guid      => identifier,
      :summary   => entry.summary,
      :content   => entry.respond_to?(:content) ? entry.content : nil
    }) if !Entry.exists?(:feed_id => feed_id, :guid => identifier)
  end

  def self.determine_identifier(feed_entry)
    identifier = feed_entry.entry_id if feed_entry.respond_to?(:entry_id)
    identifier ||= feed_entry.guid if feed_entry.respond_to?(:guid)
    identifier ||= feed_entry.url
    identifier
  end
end
