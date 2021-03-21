# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/autorun"

TEST_PASSWORD = "testing123"

# Suppresses "Starting puma..." messages to STDOUT
Capybara.server = :puma, { Silent: true }

# Have tailwind jit do a one off build instead of keeping the process in memory to watch for file changes.
ENV["TAILWIND_MODE"] ||= "build"

# Possible workaround for "random" ActionView::Template::Error: 767: unexpected token at ''
# This effectively will trigger webpacker on suite start and will result in building
# assets first (if needed) before running any tests instead of having a separate
# webpacker process per test worker which can step on each other.
# https://github.com/rails/webpacker/issues/2860
Webpacker.manifest.lookup("missing.js")

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Devise::Test::IntegrationHelpers
end
