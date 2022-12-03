# frozen_string_literal: true

require "application_system_test_case"

class UserSignsInTest < ApplicationSystemTestCase
  test "allows the user to sign in with a password" do
    visit root_path

    fill_in "password", with: TEST_PASSWORD

    click_on "Sign In"

    assert_text "Unread Entries"
  end
end
