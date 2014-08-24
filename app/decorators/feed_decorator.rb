require_relative "decorator"
class FeedDecorator < Decorator
  def entry_count
    entries.count
  end

  def unread_count
    entries.where(:read => false).count
  end

  def last_checked
    return "-" unless @model.last_checked
    I18n.localize(@model.last_checked, :format => :last_checked)
  end
end
