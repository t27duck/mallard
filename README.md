Mallard
=======

### Mallard is a self-hosted, no-nonsense, straight-forward RSS reader.

It's a Rails with Hotwire application designed to run on a Unix-based server or container.

## Requirements

* Ruby (as specified in .ruby-version)
* SQLite 3.8 or later

## Setup

* Run `bundle install` to install runtime dependencies
* If wanting to run in production mode:
  * Be sure an environment variable called `SECRET_KEY_BASE` is set for cookie signing
  * Set the environment variable `RAILS_ENV` to "production"
  * Run `rake asset:precompile` to compile CSS
* Run `rake db:create db:schema:load` to create the database
  * If updating, run `rake db:migrate` to catch the database structure up to date.
* Run `rails s` to start CSS build watching (dev mode puma plugin) and the web server (default port 3000)

## Entry fetching and maintenance

The puma configuration file is set up through a plugin to pull new entries for all feeds every 20 minutes (relative to the time the server was started).

Alternatively, run `rake entries:fetch` to pull any new entries from all feeds. This would be commonly done through a cron job.

Run `rake entries:clean` periodically to delete older entries.
