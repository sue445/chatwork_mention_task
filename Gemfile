source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.6.4"

gem "rails", "5.2.3"

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
gem "sassc-rails"
gem "slim-rails"
gem "turbolinks"
gem "uglifier"

group :development do
  gem "annotate", ">= 2.7.3"
  gem "dotenv-rails", ">= 2.2.1"
  gem "foreman", require: false
  gem "index_shotgun", group: :test
  gem "listen"

  # TODO: Remove after https://github.com/onk/onkcop/pull/62 and https://github.com/onk/onkcop/pull/63 are merged
  # gem "onkcop", ">= 0.53.0.3", require: false
  gem "onkcop", require: false, github: "sue445/onkcop", branch: "rubocop_0.72.0"

  gem "pry-byebug", group: :test
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
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
