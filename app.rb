require "bcrypt"
require "i18n"
require "json"
require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/assetpack"
require "sinatra/contrib/all"
require "sinatra/flash"
require "sinatra/reloader"

require_relative "app/helpers/application_helper"

require_relative "app/models/config_info"

require_relative "app/util/app_setup"

I18n.enforce_available_locales = false

class Mallard < Sinatra::Base
  register Sinatra::AssetPack
  register Sinatra::ActiveRecordExtension
  register Sinatra::Contrib
  register Sinatra::Flash
  register Sinatra::Reloader

  configure do
    enable :method_override
    enable :logging
    enable :sessions
    
    set :public_dir, "public"
    set :root, File.dirname(__FILE__)
    set :session_secret, ENV["SESSION_TOKEN"] || "8675309LetsGo!"
    set :views, "app/views"

    assets do
      css_compression :simple

      css :application, [
        "/css/bootstrap.min.css",
        "/css/bootstrap-theme.min.css"
      ]

      js_compression :jsmin

      js :application, [
        "/js/bootstrap.min.js"
      ]

      prebuild true
    end

    before do
      I18n.locale = ENV["LOCALE"].present? ? ENV["LOCALE"].to_sym : :en
      redirect to("/setup") if needs_setup?(request.path)
      redirect to("/login") if require_login?(request.path) && !logged_in?
    end
  end

  helpers do
    include ApplicationHelper
  end

  get "/" do
    redirect to("/setup") if needs_setup?(request.path)
  end
end

require_relative "app/controllers/setup_controller"
