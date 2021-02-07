# frozen_string_literal: true

require "application_system_test_case"

class ViewingEntriesTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    sign_in @user
    @entry1 = entries(:one)
    @entry2 = entries(:unread)
    @entry3 = entries(:unread2)
  end

  teardown do
    sign_out @user
  end

  test "User can click on an entry and view the body" do
    visit root_path

    assert_text "Unread Entries"

    click_on @entry2.title

    assert_text @entry2.content
  end

  test "User can click on the next button and view the next item in the list" do
    visit root_path

    assert_text "Unread Entries"

    click_on @entry2.title
    click_on "Next"

    assert_text @entry3.content
  end

  test "User can click on the previous button and view the next item in the list" do
    visit root_path

    assert_text "Unread Entries"

    click_on @entry2.title
    click_on "Prev"

    assert_text @entry1.content
  end
end
