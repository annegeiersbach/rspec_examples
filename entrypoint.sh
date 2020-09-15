#!/usr/bin/env bash
set -e

# use untilfail some_command
untilfail() {
  while $@; do :; done
}
export -f untilfail

# use : n_times some_number some_command
n_times() {
  for i in `seq $1`; do $2; done
}
export -f n_times

bundle install

exec "$@"
