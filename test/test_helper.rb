ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require "database_cleaner"

require File.expand_path '../../app.rb', __FILE__

ActiveRecord::Schema.verbose = false
ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths)

DatabaseCleaner.strategy = :transaction

class MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Mallard
  end
end

module DatabaseCleanerMiniTest
  def before_setup
    super
    DatabaseCleaner.start
  end

  def after_teardown
    DatabaseCleaner.clean
    super
  end
end

class MiniTest::Unit::TestCase
  include DatabaseCleanerMiniTest
end
