module Sinatra
  module ApplicationHelper
    def needs_setup?(path)
      return false if path == "/setup"
      !( ConfigInfo.include?(:password) && ConfigInfo.include?(:auth_token) )
    end

    def require_login?(path)
      return false if ["/login", "/setup"].include?(path)
      true
    end

    def logged_in?
      session[:auth] == ConfigInfo.get(:auth_token)
    end

    def authenticate(password)
      crypt_password = BCrypt::Password.new(ConfigInfo.get_value(:password))
      if crypt_password == password
        session[:auth] = ConfigInfo.get(:auth)
        true
      else
        false
      end
    end
  end
end
