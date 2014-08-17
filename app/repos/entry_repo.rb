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
  
  def self.unread
    all.where(:starred => false)
  end

  def self.read(entry)
    entry.update_attributes(:read => true)
  end

  def self.unread(entry)
    entry.update_attributes(:read => false)
  end

  def self.star(entry)
    entry.update_attributes(:starred => true)
  end

  def self.unstar(entry)
    entry.update_attributes(:starred => false)
  end
end
