require "bcrypt"
require "i18n"
require "json"
require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/contrib/all"
require "sinatra/flash"

require_relative "app/helpers/application_helper"
require_relative "app/models/config_info"

class Mallard < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::Contrib
  register Sinatra::Flash

  configure do
    enable :method_override
    enable :logging
    enable :sessions
    
    set :session_secret, ENV["SESSION_TOKEN"] || "8675309LetsGo!"
    
    before do
      I18n.locale = ENV["LOCALE"].present? ? ENV["LOCALE"].to_sym : :en
      redirect "/setup" if needs_setup?(request.path)
      redirect "/login" if require_login?(request.path) && !logged_in?
    end
  end
end
