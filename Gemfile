source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.6.1"

gem "rails", "5.2.2.1"

gem "auto_strip_attributes"
gem "bootsnap", require: false
gem "bootstrap"
gem "bootstrap_form", ">= 4.0.0.alpha1"
gem "chatwork"
gem "chatwork_webhook_verify"
gem "connection_pool"
gem "dalli"
gem "enum_help"
gem "font-awesome-rails", ">= 4.7.0.3"
gem "global"
gem "http_accept_language"
gem "i18n-tasks"
gem "jbuilder"
gem "jquery-rails"
gem "komachi_heartbeat", github: "mitaku/komachi_heartbeat", branch: "master", ref: "cd04393" # TODO: Use gemified version
gem "newrelic_rpm"
gem "omniauth-chatwork"
gem "omniauth-oauth2", ">= 1.5.0"
gem "pg"
gem "puma"
gem "puma-heroku"
gem "rails-i18n"
gem "rollbar"
gem "sass-rails"
gem "slim-rails"
gem "turbolinks"
gem "uglifier"

group :development do
  gem "annotate", ">= 2.7.3"
  gem "dotenv-rails", ">= 2.2.1"
  gem "foreman", require: false
  gem "index_shotgun", group: :test
  gem "listen"
  gem "onkcop", require: false
  gem "pry-byebug", group: :test
end

group :test do
  gem "coveralls", ">= 0.8", require: false
  gem "factory_bot_rails", group: :development
  gem "faker"
  gem "faker-precure"
  gem "rspec-its"
  gem "rspec-rails", group: :development
  gem "simplecov", require: false
  gem "webmock"
end
