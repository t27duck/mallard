require_relative "decorator"
class EntryDecorator < Decorator
  def published_at
    date = I18n.localize(@model.published, :format => :published_at)
    I18n.translate("entry.published_at", :date => date)
  end

  def body
    entry_body = @model.content ? @model.content : @model.summary
    @model.feed.sanitize ? Loofah.scrub_fragment(entry_body, :prune).to_s : entry_body
  end

  def author
    I18n.translate("entry.written_by", :author => @model.author) if @model.author
  end
end
