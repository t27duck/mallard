# frozen_string_literal: true

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "display the sign in puage" do
    get new_session_path

    assert_response :success
  end

  test "should sign the user in" do
    post session_path, params: { password: TEST_PASSWORD }

    assert_redirected_to root_path
  end

  test "should not sign the user in if invalid password" do
    post session_path, params: { password: "#{TEST_PASSWORD}---" }

    assert_response :unprocessable_entity
  end

  test "should sign the user out" do
    sign_in

    delete session_path

    assert_redirected_to root_path

    follow_redirect!

    assert_redirected_to new_session_path

    follow_redirect!

    assert_response :success
  end
end
