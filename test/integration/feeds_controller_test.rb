# frozen_string_literal: true

require "test_helper"
require "ostruct"

class FeedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @feed = feeds(:one)
  end

  test "should get index" do
    get feeds_url

    assert_response :success
  end

  test "should get new" do
    get new_feed_url

    assert_response :success
  end

  test "should fetch feed entries" do
    Feedjira.stub(:parse, OpenStruct.new(title: "A feed", entries: [])) do
      get fetch_feed_url(@feed)
    end

    assert_redirected_to feeds_url
  end

  test "should create feed" do
    Feedjira.stub(:parse, OpenStruct.new(title: "A feed", entries: [])) do
      assert_difference("Feed.count") do
        post feeds_url, params: { feed: { url: "https://website.com/feed" } }
      end
    end

    assert_redirected_to feeds_url
  end

  test "should get edit" do
    get edit_feed_url(@feed)

    assert_response :success
  end

  test "should update feed" do
    patch feed_url(@feed), params: { feed: { title: "New Title" } }

    assert_redirected_to feeds_url

    @feed.reload

    assert_equal "New Title", @feed.title
  end

  test "should destroy feed" do
    assert_difference("Feed.count", -1) do
      delete feed_url(@feed)
    end

    assert_redirected_to feeds_url
  end
end
