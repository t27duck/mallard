class Entry < ActiveRecord::Base
  belongs_to :feed

  validates_presence_of :feed, :title, :url, :published, :guid

  scope :unread, -> { where(:read => false) }
  scope :read, -> { where(:read => true) }
  scope :starred, -> { where(:starred => true) }

  def body
    entry_body = content ? content : summary
    level = case feed.sanitization_level
    when 1
      Sanitize::Config::CUSTOM_RELAXED
    when 2
      Sanitize::Config::BASIC
    when 3
      Sanitize::Config::RESTRICTED
    when 4
      Sanitize::Config::DEFAULT
    else
      nil
    end
    level ? Sanitize.clean(entry_body, level) : entry_body
  end
end
