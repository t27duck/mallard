# frozen_string_literal: true

require "application_system_test_case"

class FirstTimeSetupTest < ApplicationSystemTestCase
  setup do
    User.delete_all
  end

  test "it prompts user to set a password and allows the user to sign in" do
    visit root_path

    assert_text "Password Setup"

    fill_in "user[password]", with: TEST_PASSWORD
    fill_in "user[password_confirmation]", with: TEST_PASSWORD

    click_on "Set Password"

    assert_text "Please sign in"

    fill_in "password", with: TEST_PASSWORD

    click_on "Sign In"

    assert_text "Unread Entries"
  end
end
