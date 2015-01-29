require "bundler"

Bundler.require

require "./mallard"
run Sinatra::Application
