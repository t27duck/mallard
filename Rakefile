require "bundler"
Bundler.setup

require "sinatra/activerecord/rake"
require "./app"

task :console do
  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end
