# frozen_string_literal: true

require "test_helper"

class SetupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    User.destroy_all
  end

  test "should create a user on setup" do
    assert_difference "User.count" do
      post setup_path, params: {
        user: { password: TEST_PASSWORD, password_confirmation: TEST_PASSWORD }
      }
    end

    assert_redirected_to root_path

    follow_redirect!

    assert_redirected_to new_session_path

    follow_redirect!

    assert_response :success
  end

  test "should fail creating a user on bad input" do
    assert_no_difference "User.count" do
      post setup_path, params: {
        user: { password: TEST_PASSWORD, password_confirmation: "#{TEST_PASSWORD}---" }
      }
    end

    assert_response :unprocessable_content
  end
end
