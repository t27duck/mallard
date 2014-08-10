module ApplicationHelper
  def needs_setup?(path=nil)
    return false if path == "/setup"
    return false if path =~ /css/ || path =~ /js/ || path =~ /img/
    !setup_complete?
  end

  def setup_complete?
    ConfigInfo.include?(:password) && ConfigInfo.include?(:auth_token)
  end

  def require_login?(path=nil)
    return false if ["/login", "/setup"].include?(path)
    return false if path =~ /css/ || path =~ /js/ || path =~ /img/
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
end
