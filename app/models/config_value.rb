class ConfigValue < ActiveRecord::Base
  def self.has_value?(key)
    where(:key => key).exists?
  end
end
