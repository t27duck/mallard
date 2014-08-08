require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/contrib/all"
require "sinatra/flash"
require "json"
require "i18n"

class Mallard < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end
