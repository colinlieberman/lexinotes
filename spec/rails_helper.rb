# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter %r{^/spec/}
  add_filter %r{^/lib/}
  add_filter %r{^/config/}
  add_filter %r{^/app/admin/}
end

# This file is copied to spec/ when you run 'rails generate rspec:install'

require 'spec_helper'
require 'shoulda/matchers'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

require 'rake'
Rails.application.load_tasks

require "capybara/rails"
require "selenium/webdriver"
Capybara.server = :puma, { Silent: true }
Capybara.register_driver :headless_chrome do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.args << '--headless'
      opts.args << '--window-size=1440,900'
      opts.args << '--disable-gpu' if Gem.win_platform?
      # Workaround https://bugs.chromium.org/p/chromedriver/issues/detail?id=2650&q=load&sort=-id&colspec=ID%20Status%20Pri%20Owner%20Summary
      opts.args << '--disable-site-isolation-trials'
      opts.args << '--no-sandbox'
  end

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end
Capybara.javascript_driver = :headless_chrome

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  # config.include Devise::Test::ControllerHelpers, type: :controller
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation, except: %w[ar_internal_metadata])
  end

  config.before(:each) do |example|
    unless example.metadata[:skip_db_cleaner]
      DatabaseCleaner.start
    end
  end

  config.append_after(:each) do |example|
    unless example.metadata[:skip_db_cleaner]
      DatabaseCleaner.clean
    end
  end

  # config.include Devise::Test::IntegrationHelpers, type: :feature

  # config.include ControllerSpecHelper, type: :controller
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
