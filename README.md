Mallard
=======

[![Build Status](https://travis-ci.org/t27duck/mallard.svg?branch=master)](https://travis-ci.org/t27duck/mallard)
[![Code Climate](https://codeclimate.com/github/t27duck/mallard/badges/gpa.svg)](https://codeclimate.com/github/t27duck/mallard)
[![Test Coverage](https://codeclimate.com/github/t27duck/mallard/badges/coverage.svg)](https://codeclimate.com/github/t27duck/mallard)

### Mallard is a self-hosted, no-nonsense, straight-forward RSS reader.

It's a sinatra application can run on any Unix-based server.

## Requirements

The app should run fine on Ruby 1.9.3, 2.0, 2.1, and 2.2. The `bundler` gem is also required to install depedancies.

You will also need PostgreSQL to store the feed and entry information.

## Installing/Updating/Configuring

Check out the repo and navigate to the root of the app. Install the required gems using `bundle`.

Copy `config/database.example.yml` to `config/database.yml` and update the configuration to fit your needs.

Create the database by running `RACK_ENV=xxx bundle exec rake db:create`

Create/update the table structure wtih `RACK_ENV=xxx bundle exec rake db:migrate`

You can start the app by running `RACK_ENV=xxx bundle exec unicorn -c config/unicorn.rb`

Replace xxx with either "production" or "development", depending on which environment you wish to run the app under. If not specificed, `RACK_ENV` defaults to development.

The default port unicorn runs on is 8080.

When you visit the app for the first time in your browser (http://localhost:8080), you will be prompted to create a password. Once that is entered, you'll be able to login.

Once logged in, go to "Manage Feeds" and then click the "Add" button to start adding your feeds.

## Fetching Entries

The manage feeds page has a manual fetch button for each feed you have configured.

You can also fetch new entries for all feeds by running `rake fetch`

## App Concole

Running `RACK_ENV=xxx bundle exec rake console` will drop you in an irb session within the app - allowing you to view and manipulate the models.

## Tests

Tests are written in MiniTest and can be ran with `bundle exec rake test`. An in-memory SQLite database is used during tests.

## Contributing

1. Fork it ( http://github.com/t27duck/mallard/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
