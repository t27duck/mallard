require File.expand_path '../../../test_helper.rb', __FILE__

class ApplicationHelperTest < MiniTest::Test
  def test_setup_complete_is_true_when_everything_is_configured
    complete_setup
    assert setup_complete?
  end

  def test_setup_complete_is_false_when_everything_is_not_configured
    assert !setup_complete?
  end

  def test_needs_setup_is_false_when_everything_is_configured
    complete_setup
    assert !needs_setup?
  end

  def test_needs_setup_is_false_if_the_path_is_setup
    assert !needs_setup?("/setup")
    complete_setup
    assert !needs_setup?("/setup")
  end

  def test_needs_setup_is_true_when_everything_is_not_configured
    assert needs_setup?
  end

  def test_logged_in_is_false_if_session_auth_token_is_not_set_or_doesnt_match
    complete_setup
    assert !logged_in?
    session["auth"] = ConfigInfoRepo.get(:auth_token)+"1234"
    assert !logged_in?
  end

  def test_logged_in_is_false_if_session_auth_token_matches
    complete_setup
    session["auth"] = ConfigInfoRepo.get(:auth_token)
    assert logged_in?
  end

  def test_authenticate_is_true_if_passwords_match
    complete_setup
    assert authenticate(TEST_PASSWORD)
    assert_equal ConfigInfoRepo.get(:auth_token), session["auth"]
  end

end
