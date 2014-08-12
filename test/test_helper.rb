ENV['RACK_ENV'] = "test"
require "minitest/autorun"
require "rack/test"
require "database_cleaner"
require "ostruct"

require File.expand_path "../../app.rb", __FILE__

require "active_record/fixtures"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Schema.verbose = false
ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths)
Dir.glob(File.join(File.dirname(__FILE__), 'fixtures', '*.{yml,csv}')).each do |fixture_file|
  ActiveRecord::FixtureSet.create_fixtures('test/fixtures', File.basename(fixture_file, '.*'))
end

DatabaseCleaner.strategy = :transaction

class MiniTest::Test
  include Rack::Test::Methods

  class AppHelper
    attr_accessor :session
    include ApplicationHelper
  end

  def before_setup
    super
    DatabaseCleaner.start
    @helpers = AppHelper.new
    @helpers.session = {}
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

  def assert_redirected(path, message=nil)
    assert_equal 302, last_response.status, message
    assert_equal last_response.location, "http://example.org#{path}", message
  end
end
