require File.expand_path '../test_helper.rb', __FILE__

class SetupControllerTest < MiniTest::Test

  def test_when_config_isnt_set_redirect_to_setup
    get "/"
    assert_equal 302, last_response.status
    assert_equal last_response.location, "http://example.org/setup"
  end

  def test_when_config_isnt_set_allow_access_to_setup
    get "/setup"
    assert_equal 200, last_response.status
  end

  def test_when_config_set_disallow_access_to_setup
    complete_setup
    get "/setup"
    assert_equal 302, last_response.status
    assert_equal last_response.location, "http://example.org/"
  end

end
