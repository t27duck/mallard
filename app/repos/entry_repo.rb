class EntryRepo
  def self.find(id)
    Entry.find(id)
  end

  def self.all
    Entry.order(:published => :desc)
  end
 
  def self.unread
    all.where(:read => false)
  end
 
  def self.read
    all.where(:read => true)
  end
  
  def self.starred
    all.where(:starred => true)
  end

  def self.update(entry, attrs)
    entry.update_attributes(attrs)
  end
end
