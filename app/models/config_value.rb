class ConfigValue < ActiveRecord::Base
  def self.has_value?(key)
    where(:key => key).exists?
  end

  def self.get_value(key)
    record = where(:key => key).first
    raise ArgumentError, "Invalid key: #{key}" unless record
    record.value
  end

  def self.set_value(key, value)
    record = find_or_initalize_by(:key => key)
    record.value = value
    record.save!
  end
end
