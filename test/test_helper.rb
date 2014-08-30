ENV['RACK_ENV'] = "test"
require "minitest/autorun"
require "rack/test"
require "database_cleaner"
require "nokogiri"
require "ostruct"
require "mocha/mini_test"

require File.expand_path "../../mallard.rb", __FILE__

require "active_record/fixtures"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Schema.verbose = false
ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths)
Dir.glob(File.join(File.dirname(__FILE__), 'fixtures', '*.{yml,csv}')).each do |fixture_file|
  ActiveRecord::FixtureSet.create_fixtures('test/fixtures', File.basename(fixture_file, '.*'))
end

DatabaseCleaner.strategy = :transaction

class MiniTest::Test
  def session
    @session ||= {}
  end

  include Rack::Test::Methods

  include ApplicationHelper

  def before_setup
    super
    DatabaseCleaner.start
  end

  def after_teardown
    DatabaseCleaner.clean
    ENV["BYPASS_LOGIN"] = nil
    super
  end

  def app
    Mallard
  end

  def complete_setup
    ConfigInfo.create!(:key => "password", :value => BCrypt::Password.create("12345"))
    ConfigInfo.create!(:key => "auth_token", :value => "12345")
  end

  def log_user_in
    ENV["BYPASS_LOGIN"] = "yes"
  end

  def assert_response(code, message=nil)
    assert_equal code, last_response.status, message
  end

  def assert_redirected(path, message=nil)
    assert_response 302, message
    assert_equal last_response.location, "http://example.org#{path}", message
  end
end
