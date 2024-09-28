# frozen_string_literal: true

require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in
    Entry.reindex
  end

  test "should get unread entries" do
    get unread_entries_url

    assert_response :success
    assert_select "a", entries(:unread).title
  end

  test "should be able to search entries" do
    entry = entries(:unread2)
    entry.update!(title: "searchable")

    get unread_entries_url, params: { search: "searchable" }

    assert_response :success

    assert_select "a", entry.title
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

    assert entry.read
  end
end
