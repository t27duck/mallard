require "bundler"
Bundler.setup

require "sinatra/activerecord/rake"
require "./app"

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end

task :console do
  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end
