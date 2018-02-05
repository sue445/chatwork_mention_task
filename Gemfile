source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.0"

gem "rails", "5.2.0.rc1"

gem "auto_strip_attributes"
gem "bootsnap", require: false
gem "bootstrap"
gem "bootstrap_form", github: "bootstrap-ruby/rails-bootstrap-forms", branch: "master", ref: "8a7188f"
gem "chatwork"
gem "chatwork_webhook_verify"
gem "connection_pool"
gem "dalli"
gem "enum_help"
gem "font-awesome-rails"
gem "global"
gem "jbuilder"
gem "jquery-rails"
gem "komachi_heartbeat", github: "mitaku/komachi_heartbeat", branch: "master", ref: "cd04393" # TODO: Use gemified version
gem "newrelic_rpm"
gem "omniauth-chatwork"
gem "pg"
gem "puma"
gem "puma-heroku"
gem "rollbar"
gem "sass-rails"
gem "slim-rails"
gem "turbolinks"
gem "uglifier"

group :development do
  # annotate v2.7.2 + rails v5.2.0.beta2 doesn't work, but fixed at develop
  # TODO: Upgrade to v2.7.3+
  gem "annotate", github: "ctran/annotate_models", branch: "develop", ref: "e3e0bbe"

  gem "dotenv-rails", ">= 2.2.1"
  gem "foreman", require: false
  gem "index_shotgun", group: :test
  gem "listen"
  gem "onkcop", require: false
  gem "pry-byebug", group: :test
end

group :test do
  gem "factory_bot_rails", group: :development
  gem "faker"
  gem "faker-precure"
  gem "rspec-its"
  gem "rspec-rails", group: :development
end
