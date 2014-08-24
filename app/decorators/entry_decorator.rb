require_relative "decorator"
class EntryDecorator < Decorator
  def published
    I18n.localize(@model.published, :format => :published_at)
  end

  def body
    entry_body = @model.content ? @model.content : @model.summary
    @model.feed.sanitize ? Loofah.scrub_fragment(entry_body, :prune).to_s : entry_body
  end
end
