require File.expand_path '../../../test_helper.rb', __FILE__

class SetupControllerTest < MiniTest::Test

  def test_when_config_isnt_set_redirect_to_setup
    get "/"
    assert_redirected "/setup"
  end

  def test_when_config_isnt_set_allow_access_to_setup
    get "/setup"
    assert_response 200
  end

  def test_when_config_set_disallow_access_to_setup
    complete_setup
    get "/setup"
    assert_redirected "/"
  end

  def test_posting_to_setup_path_completes_setup
    password = "12345"
    post "/setup", {:password => password, :password_confirmation => password}
    assert setup_complete?
    assert_redirected "/"
  end

  def test_posting_to_setup_path_fails_if_passwords_dont_match
    password = "12345"
    password_confirmation = "54321"
    post "/setup", {:password => password, :password_confirmation => password_confirmation}
    assert !setup_complete?
    assert_redirected "/setup"
  end


end
