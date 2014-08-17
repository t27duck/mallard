class FeedDecorator < Decorator
  def entry_count
    entries.count
  end

  def unread_count
    entries.where(:read => false).count
  end
end
