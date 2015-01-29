class ConfigInfo < ActiveRecord::Base
  validates :key, :value, :presence => true
  validates :key, :uniqueness => true
end
