# frozen_string_literal: true

require "test_helper"

class ReadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in
    Entry.reindex
  end

  test "should get read entries" do
    get read_url

    assert_response :success
    assert_select "a", entries(:read).title
  end

  test "should be able to search entries" do
    entry = entries(:read)
    entry.update!(title: "searchable")

    get read_url, params: { search: "searchable" }

    assert_response :success

    assert_select "a", entry.title
  end
end
