class FeedRepo
  def self.all
    Feed.order(:title)
  end

  def self.find(id)
    Feed.find(id)
  end

  def self.create(url, sanitize)
    feed = Feed.new(:url => url, :sanitize => sanitize)
    feed.save
    feed
  end

  def self.update(feed, title, sanitize)
    feed.title    = title
    feed.sanitize = sanitize
    feed.save
    feed
  end

  def self.update_last_checked(feed, last_checked=Time.now)
    feed.update_attributes(:last_checked => last_checked)
  end
end
