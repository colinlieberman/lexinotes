# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "activeadmin"
gem "bootsnap", ">= 1.4.4", require: false
gem "font-awesome-rails"
gem "haml-rails"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "pg"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.7"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"

group :development, :test do
  gem "byebug"
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "simplecov"
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara"
  gem "capybara-selenium"
  gem "database_cleaner"
  gem "selenium-webdriver"
end
