module Sinatra
  module ApplicationHelper
    def needs_setup?(path)
      return false if path == "/setup"
      !( ConfigValue.has_value?(:password) && ConfigValue.has_value?(:auth_token) )
    end

    def require_login?(path)
      return false if path == "/login"
      true
    end

    def logged_in?
      session[:auth] == ConfigValue.get_value(:auth_token)
    end

    def authenticate(password)
      crypt_password = BCrypt::Password.new(ConfigValue.get_value(:password))
      if crypt_password == password
        session[:auth] = ConfigValue.get_value(:auth)
        true
      else
        false
      end
    end
  end
end
