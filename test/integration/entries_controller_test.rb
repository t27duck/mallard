# frozen_string_literal: true

require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
  end

  test "should get unread entries" do
    get unread_entries_url
    assert_response :success
    assert_select "a", entries(:unread).title
  end

  test "should get read entries" do
    get read_entries_url
    assert_response :success
    assert_select "a", entries(:read).title
  end

  test "should get starred entries" do
    get starred_entries_url
    assert_response :success
    assert_select "a", entries(:starred).title
  end

  test "should update entry" do
    entry = entries(:one)

    patch entry_url(entry, format: :turbo_stream), params: { entry: { read: true } }
    assert_response :success

    entry.reload
    assert_equal true, entry.read
  end
end
