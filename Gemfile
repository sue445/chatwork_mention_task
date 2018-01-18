source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.0"

gem "rails", "~> 5.2.0.beta2"

gem "bootsnap", require: false
gem "bootstrap", "~> 4.0.0.beta3"
gem "jbuilder"
gem "jquery-rails"
gem "pg", "~> 0.18"
gem "puma"
gem "rollbar"
gem "sass-rails"
gem "slim-rails"
gem "turbolinks"
gem "uglifier"

group :development do
  gem "foreman", require: false
  gem "listen"
  gem "onkcop", require: false
  gem "pry-byebug", group: :test
end

group :test do
  gem "rspec-rails", group: :development
end
