class Feed < ActiveRecord::Base
  
  has_many :entries, :dependent => :delete_all

  validates_presence_of :title, :url

  before_validation :set_info!, :if => lambda{ |model| model.new_record? }
  after_create :fetch!

  def set_info!
    if feed_object.respond_to?(:title)
      self.title         = feed_object.title
      self.etag          = feed_object.etag
      self.last_modified = feed_object.last_modified
    else
      self.errors.add(:base, 'Unable to parse feed')
    end
  end

  def fetch!
    Timeout::timeout(10) {
      create_new_entries!
      self.last_checked = Time.now
      save!
    }
  rescue Timeout::Error
  end

  def unread_count
    @unread_count ||= entries.unread.count
  end

  private ######################################################################

  def create_new_entries!
    feed_object.entries.each do |e|
      identifier = determine_identifier(e)
      Entry.create_from_feedzirra(id, identifier, e)
    end
  rescue
    self.errors.add(:base, 'There was an error parsing entries in this feed')
    raise
  end

  def feed_object
    @feed_object ||= Feedzirra::Feed.fetch_and_parse(url)
  end

  def determine_identifier(feed_entry)
    identifier = feed_entry.entry_id if feed_entry.respond_to?(:entry_id)
    identifier ||= feed_entry.guid if feed_entry.respond_to?(:guid)
    identifier ||= feed_entry.url
    identifier
  end

end
