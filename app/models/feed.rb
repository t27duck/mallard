class Feed < ActiveRecord::Base
  SANITATION_LEVELS = {
    0 => 'none',
    1 => 'relaxed',
    2 => 'basic',
    3 => 'restricted',
    4 => 'full'
  }

  validates_presence_of :title, :sanitization_level, :url

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

  private ######################################################################

  def feed_object
    @feed_object ||= Feedzirra::Feed.fetch_and_parse(url)
  end

end
