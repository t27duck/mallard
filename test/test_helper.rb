ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require "database_cleaner"

require File.expand_path '../../app.rb', __FILE__

ActiveRecord::Schema.verbose = false
ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths)

DatabaseCleaner.strategy = :transaction

class MiniTest::Test
  include Rack::Test::Methods

  def before_setup
    super
    DatabaseCleaner.start
  end

  def after_teardown
    DatabaseCleaner.clean
    super
  end

  def app
    Mallard
  end

  def complete_setup
    ConfigInfo.create!(:key => "password", :value => BCrypt::Password.create("12345"))
    ConfigInfo.create!(:key => "auth_token", :value => "12345")
  end
end
