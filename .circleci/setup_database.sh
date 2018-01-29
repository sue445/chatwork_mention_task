#!/bin/bash -xe

# Wait for db
# https://circleci.com/docs/2.0/postgres-config/#using-dockerize
# dockerize is already installed in circleci/ruby
dockerize -wait tcp://localhost:5432 -timeout 1m

./bin/rails db:create
./bin/rails db:schema:load
