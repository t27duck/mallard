module Sinatra
  module ApplicationHelper
    def needs_setup?
      !( ConfigValue.has_value?(:password) && ConfigValue.has_value?(:auth_token) )
    end

    def require_login?
    end

    def logged_in?
    end
  end
end
