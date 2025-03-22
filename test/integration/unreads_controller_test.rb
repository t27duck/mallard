# frozen_string_literal: true

require "test_helper"

class UnreadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in
    Entry.reindex
  end

  test "should get unread entries" do
    get unread_url

    assert_response :success
    assert_select "a", entries(:unread).title
  end

  test "should be able to search entries" do
    entry = entries(:unread2)
    entry.update!(title: "searchable")

    get unread_url, params: { search: "searchable" }

    assert_response :success

    assert_select "a", entry.title
  end
end
