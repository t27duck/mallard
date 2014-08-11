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

require_relative "boot/plugins"
require_relative "boot/configure"
require_relative "boot/helpers"
require_relative "boot/app"

I18n.enforce_available_locales = false

require_relative "app/controllers/setup_controller"
