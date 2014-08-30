require "bcrypt"
require "feedjira"
require "i18n"
require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/assetpack"
require "sinatra/contrib/all"
require "sinatra/flash"
require "sinatra/reloader"
require "will_paginate"
require "will_paginate/active_record"

Dir.glob('./app/{controllers,decorators,helpers,models,repos,util}/*.rb').each { |file| require file }
I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'config/locales', '*.yml').to_s]
I18n.enforce_available_locales = false

class Mallard < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::AssetPack
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
        "/js/jquery.fitvids.js",
        "/js/jquery.hotkeys.js",
        "/js/bootstrap.min.js",
        "/js/application.js"
      ]

      prebuild true
    end

    before do
      I18n.locale = ENV["LOCALE"].nil? ? :en : ENV["LOCALE"].to_sym
      redirect to("/setup") if needs_setup?(request.path)
      redirect to("/login") if require_login?(request.path) && !logged_in?
    end

    error ActiveRecord::RecordNotFound do
      status 404
      body "Not found!"
    end
  end
end
