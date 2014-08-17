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
  
  def self.mark_read(entry)
    entry.update_attributes(:read => true)
  end

  def self.mark_unread(entry)
    entry.update_attributes(:read => false)
  end

  def self.mark_star(entry)
    entry.update_attributes(:starred => true)
  end

  def self.mark_unstar(entry)
    entry.update_attributes(:starred => false)
  end
end
