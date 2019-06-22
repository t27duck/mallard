#!/bin/sh
set -e

# if the server was not shut down properly the pid file will need to be removed
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle check || bundle install
if test -z "$SKIP_YARN"; then
  yarn install
fi

bundle exec "$@"
