source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.0"

gem "rails", "~> 5.2.0.beta2"

gem "bootsnap", require: false
gem "bootstrap"
gem "font-awesome-rails"
gem "jbuilder"
gem "jquery-rails"
gem "newrelic_rpm"
gem "omniauth-chatwork"
gem "pg", "~> 0.18"
gem "puma"
gem "rollbar"
gem "sass-rails"
gem "slim-rails"
gem "turbolinks"
gem "uglifier"

group :development do
  # annotate v2.7.2 + rails v5.2.0.beta2 doesn't work, but fixed at develop
  # TODO: Upgrade to v2.7.3+
  gem "annotate", github: "ctran/annotate_models", branch: "develop"

  gem "dotenv-rails"
  gem "foreman", require: false
  gem "listen"
  gem "onkcop", require: false
  gem "pry-byebug", group: :test
end

group :test do
  gem "rspec-rails", group: :development
end
