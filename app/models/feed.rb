class Feed < ActiveRecord::Base
  has_many :entries, :dependent => :delete_all

  validates_presence_of :title, :url

  before_validation :set_info, :if => lambda{ |model| model.new_record? }

  def feed_object
    @feed_object ||= Feedjira::Feed.fetch_and_parse(url)
  end

  private ######################################################################

  def set_info
    self.title ||= url
    if feed_object.respond_to?(:title)
      self.title         = feed_object.title
      self.etag          = feed_object.etag
      self.last_modified = feed_object.last_modified
    else
      self.errors.add(:base, 'Unable to parse feed')
    end
  end

end
