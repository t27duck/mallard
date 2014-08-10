require File.expand_path '../test_helper.rb', __FILE__

class ApplicationHelperTest < MiniTest::Test

  class AppHelper
    attr_accessor :session
    include ApplicationHelper
  end

  def setup
    @helpers = AppHelper.new
    @helpers.session = {}
  end

  def test_setup_complete_is_true_when_everything_is_configured
    complete_setup
    assert @helpers.setup_complete?
  end
  
  def test_setup_complete_is_false_when_everything_is_not_configured
    assert !@helpers.setup_complete?
  end  
  
  def test_needs_setup_is_false_when_everything_is_configured
    complete_setup
    assert !@helpers.needs_setup?
  end

  def test_needs_setup_is_false_if_the_path_is_setup
    assert !@helpers.needs_setup?("/setup")
    complete_setup
    assert !@helpers.needs_setup?("/setup")
  end
  
  def test_needs_setup_is_true_when_everything_is_not_configured
    assert @helpers.needs_setup?
  end

  def test_logged_in_is_false_if_session_auth_token_is_not_set_or_doesnt_match
    complete_setup
    assert !@helpers.logged_in?
    @helpers.session[:auth] = ConfigInfo.get(:auth_token)+"1234"
    assert !@helpers.logged_in?
  end

  def test_logged_in_is_false_if_session_auth_token_matches
    complete_setup
    @helpers.session[:auth] = ConfigInfo.get(:auth_token)
    assert @helpers.logged_in?
  end

  def test_authenticate_is_true_if_passwords_match
    complete_setup
    assert @helpers.authenticate("12345")
    assert_equal ConfigInfo.get(:auth_token), @helpers.session[:auth]
  end

end
