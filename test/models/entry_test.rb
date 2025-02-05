# frozen_string_literal: true

require "test_helper"

class EntryTest < ActiveSupport::TestCase
  setup do
    @feed = feeds(:one)
  end

  test "#final_url returns existing url if strip tracking is off" do
    @feed.update!(remove_tracking_params: false)

    entry = Entry.new(feed: @feed, url: "https://example.com/?utm_source=aaa&utm_medium=1&other=2")

    assert_equal "https://example.com/?utm_source=aaa&utm_medium=1&other=2", entry.final_url

    entry = Entry.new(feed: @feed, url: "https://example.com/?other=2")

    assert_equal "https://example.com/?other=2", entry.final_url

    entry = Entry.new(feed: @feed, url: "https://example.com/?utm_source=aaa&utm_medium=1")

    assert_equal "https://example.com/?utm_source=aaa&utm_medium=1", entry.final_url
  end

  test "#final_url returns cleaned url if strip tracking is on" do
    @feed.update!(remove_tracking_params: true)

    entry = Entry.new(feed: @feed, url: "https://example.com/?utm_source=aaa&utm_medium=1&other=2")

    assert_equal "https://example.com/?other=2", entry.final_url

    entry = Entry.new(feed: @feed, url: "https://example.com/?other=2")

    assert_equal "https://example.com/?other=2", entry.final_url

    entry = Entry.new(feed: @feed, url: "https://example.com/?utm_source=aaa&utm_medium=1")

    assert_equal "https://example.com/", entry.final_url
  end

  test "#final_url returns original url if strip tracking is on but there's no query" do
    @feed.update!(remove_tracking_params: true)

    entry = Entry.new(feed: @feed, url: "https://example.com")

    assert_equal "https://example.com", entry.final_url
  end
end
