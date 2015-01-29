class ConfigInfoRepo
  def self.include?(key)
    ConfigInfo.where(:key => key).exists?
  end

  def self.get(key)
    record = ConfigInfo.where(:key => key).first
    raise ArgumentError, "Invalid key: #{key}" unless record
    record.value
  end

  def self.set(key, value)
    record = ConfigInfo.find_or_initialize_by(:key => key)
    record.value = value
    record.save!
  end
end
