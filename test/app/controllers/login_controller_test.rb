require File.expand_path '../../../test_helper.rb', __FILE__

class LoginControllerTest < MiniTest::Test

  def setup
    complete_setup
  end

  def test_login_renders_if_user_is_not_logged_in
    get "/login"
    assert_response 200
  end

  def test_login_redirects_if_user_is_logged_in
    log_user_in
    get "/login"
    assert_redirected "/"
  end

  def test_login_post_rerenders_if_user_fails_logging_in
    post "/login", :password => "wrong!"
    assert_response 200
  end

  def test_login_post_redirects_if_user_is_logged_in
    log_user_in
    post "/login"
    assert_redirected "/"
  end

  def test_login_post_redirects_if_user_logs_in_successfully
    post "/login", :password => "12345"
    assert_redirected "/"
  end

end
