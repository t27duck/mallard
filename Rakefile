require "bundler"
Bundler.setup

require "sinatra/activerecord/rake"
require "./mallard"

require "rake/testtask"
Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

desc "Fetch new entries for all feeds"
task :fetch do
  EntryFetcher.fetch_all
end

desc "Run a console with the app environment loaded"
task :console do
  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end
