# frozen_string_literal: true

require "application_system_test_case"

class UserSignsInTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  teardown do
    sign_out @user
  end

  test "allows the user to sign in with a password" do
    sign_out @user
    visit root_path

    fill_in "user[password]", with: TEST_PASSWORD

    click_on "Sign In"

    assert_text "Unread Entries"
  end
end
