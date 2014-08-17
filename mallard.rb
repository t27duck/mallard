require "bcrypt"
require "feedjira"
require "i18n"
require "json"
require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/assetpack"
require "sinatra/contrib/all"
require "sinatra/flash"
require "sinatra/reloader"

def require_dir(path)
  Dir["#{path}/*.rb"].each {|file| require_relative file }
end

I18n.enforce_available_locales = false

require_dir "app/helpers"

class Mallard < Sinatra::Base
  register Sinatra::AssetPack
  register Sinatra::ActiveRecordExtension
  register Sinatra::Contrib
  register Sinatra::Flash
  register Sinatra::Reloader

  helpers do
    include ApplicationHelper
  end
  
  configure do
    enable :method_override
    enable :logging
    enable :sessions unless test?
    
    set :public_dir, "public"
    set :root, File.dirname(__FILE__)
    set :session_secret, ENV["SESSION_TOKEN"] || "8675309LetsGo!"
    set :views, "app/views"

    assets do
      css_compression :simple

      css :application, [
        "/css/bootstrap.min.css",
        "/css/bootstrap-theme.min.css",
        "/css/main.css"
      ]

      js_compression :jsmin

      js :application, [
        "/js/jquery-2.1.1.min.js",
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
  
  error ActiveRecord::RecordNotFound do
    status 404
    body "Not found!"
  end

  get "/" do
    @entries = Decorator.generate(EntryRepo.unread)
    erb :root
  end
end


require_dir "app/models"
require_dir "app/decorators"
require_dir "app/repos"
require_dir "app/util"
require_dir "app/controllers"
