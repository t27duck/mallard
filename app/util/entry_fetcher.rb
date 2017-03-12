require 'timeout'

class EntryFetcher
  def self.fetch_all
    FeedRepo.all.each do |feed|
      new(feed).fetch
    end
  end

  def initialize(feed)
    @feed = feed
  end

  def fetch(options={})
    raise_errors = options.fetch(:raise_errors, false)
    Timeout::timeout(10) do
      @feed.feed_object.entries.each do |entry|
        Entry.create_from_feedjira(@feed.id, entry)
      end
      FeedRepo.update_last_checked(@feed)
    end
  rescue
    raise if raise_errors
  end
end
