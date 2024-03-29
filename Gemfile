source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 6.1.1"

gem "auto_strip_attributes"
gem "bootsnap", require: false
gem "bootstrap", ">= 5.0.0"
gem "bootstrap_form", ">= 5.0.0"
gem "chatwork", ">= 1.0.0"
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
gem "net-imap"
gem "net-pop"
gem "net-smtp"
gem "newrelic_rpm"
gem "nokogiri", ">= 1.11.0.rc4"
gem "omniauth-chatwork"
gem "omniauth-oauth2", ">= 1.5.0"
gem "omniauth-rails_csrf_protection"
gem "pg"
gem "puma", "< 5.0.0" # FIXME: app is crashed when puma v5+
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
  gem "onkcop", ">= 1.0.0.0", require: false
  gem "pry-byebug", group: :test
  gem "rubocop_auto_corrector", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", ">= 2.0.0.pre", require: false
end

group :test do
  gem "coveralls", ">= 0.8", require: false
  gem "factory_bot_rails", group: :development
  gem "faker"
  gem "faker-precure"
  gem "rspec-its"
  gem "rspec-rails", group: :development
  gem "rubicure", ">= 3.0.0"
  gem "simplecov", require: false
  gem "webmock"
end
