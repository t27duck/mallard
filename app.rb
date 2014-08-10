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

require_relative "app/bootstrap/plugins"
require_relative "app/bootstrap/configure"

I18n.enforce_available_locales = false

class Mallard < Sinatra::Base
  helpers do
    include ApplicationHelper
  end

  get "/" do
    redirect to("/setup") if needs_setup?(request.path)
  end
end

require_relative "app/controllers/setup_controller"
