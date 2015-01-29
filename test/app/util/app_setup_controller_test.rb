require File.expand_path '../../../test_helper.rb', __FILE__

class AppSetupTest < MiniTest::Test
  def test_set_password_sets_password_and_resets_auth_token
    AppSetup.set_password("password")
    assert ConfigInfoRepo.get(:password)
    assert ConfigInfoRepo.get(:auth_token)
  end
end
