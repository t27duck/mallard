# frozen_string_literal: true

require "application_system_test_case"

class FirstTimeSetupTest < ApplicationSystemTestCase
  setup do
    User.delete_all
  end

  teardown do
    sign_out User.last if User.last.present?
  end

  test "It prompts user to set a password and logs user in" do
    visit root_path

    assert_text "Password Setup"

    fill_in "user[password]", with: TEST_PASSWORD
    fill_in "user[password_confirmation]", with: TEST_PASSWORD

    click_on "Set Password"

    assert_text "Unread Entries"
  end
end
