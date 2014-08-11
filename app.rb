require "bcrypt"
require "feedzirra"
require "i18n"
require "json"
require "sanitize"
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

# These files need to be loaded in a specific order
require_relative "boot/plugins"
require_relative "boot/configure"
require_relative "boot/helpers"
require_relative "boot/app"
require_relative "boot/sanitize"

require_dir "app/models"
require_dir "app/util"
require_dir "app/controllers"
