class ConfigInfo < ActiveRecord::Base

  validate :key, :value, :presense => true
  validate :key, :uniqueness => true

  def self.include?(key)
    where(:key => key).exists?
  end

  def self.get(key)
    record = where(:key => key).first
    raise ArgumentError, "Invalid key: #{key}" unless record
    record.value
  end

  def self.set(key, value)
    record = find_or_initialize_by(:key => key)
    record.value = value
    record.save!
  end
end
