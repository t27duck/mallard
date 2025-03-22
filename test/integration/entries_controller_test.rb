# frozen_string_literal: true

require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in
    Entry.reindex
  end

  test "should update entry" do
    entry = entries(:one)

    patch entry_url(entry, format: :turbo_stream), params: { entry: { read: true } }

    assert_response :success

    entry.reload

    assert entry.read
  end
end
