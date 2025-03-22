# frozen_string_literal: true

require "test_helper"

class StarredsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in
    Entry.reindex
  end

  test "should get read entries" do
    get starred_url

    assert_response :success
    assert_select "a", entries(:starred).title
  end

  test "should be able to search entries" do
    entry = entries(:starred)
    entry.update!(title: "searchable")

    get starred_url, params: { search: "searchable" }

    assert_response :success

    assert_select "a", entry.title
  end
end
