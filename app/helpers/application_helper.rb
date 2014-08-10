module ApplicationHelper
  def needs_setup?(path="")
    return false if path == "/setup" || asset_path?(path)
    !setup_complete?
  end

  def setup_complete?
    ConfigInfo.include?(:password) && ConfigInfo.include?(:auth_token)
  end

  def require_login?(path="")
    return false if ["/login", "/setup"].include?(path) || asset_path?(path)
    true
  end

  def logged_in?
    session[:auth] == ConfigInfo.get(:auth_token)
  end

  def authenticate(password)
    crypt_password = BCrypt::Password.new(ConfigInfo.get(:password))
    if crypt_password == password
      session[:auth] = ConfigInfo.get(:auth_token)
      true
    else
      false
    end
  end

  private ######################################################################

  def asset_path?(path)
    path =~ /css/ || path =~ /js/ || path =~ /img/ || path =~ /fonts/
  end
end
