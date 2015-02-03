class EntryRepo
  def self.find(id)
    Entry.find(id)
  end

  def self.all
    Entry.order(:published => :asc)
  end

  def self.unread
    all.where(:read => false)
  end

  def self.read(options={})
    search = options.fetch(:search, nil)
    scope = all
    scope = scope.where(Entry.arel_table[:title].matches("%#{search}%")) if search.to_s != ""
    scope.where(:read => true)
  end

  def self.starred
    all.where(:starred => true)
  end

  def self.update(entry, attrs)
    entry.update_attributes(attrs)
  end
end
