# frozen_string_literal: true

source 'https://rubygems.org'

# Rails framework
gem 'rails', '~> 8.0.1'

# Modern asset pipeline
gem 'propshaft'

# Database (SQLite)
gem 'sqlite3', '>= 2.1'

# Recommended web server for Rails
gem 'puma', '>= 5.0'

# Import maps for managing JavaScript without Webpacker
gem 'importmap-rails'

# Hotwire: Enhances interactivity and application speed
gem 'stimulus-rails'
gem 'turbo-rails'

# JSON API generator (for future endpoints if needed)
gem 'jbuilder'

# Time zone correction for Windows (optional)
gem 'tzinfo-data', platforms: %i[windows jruby]

# Efficient caching for Rails 8
gem 'solid_cache'

# Reduces boot times
gem 'bootsnap', require: false

group :development, :test do
  # Rails debugger
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'

  # Security analysis for vulnerabilities
  gem 'brakeman', require: false

  # Ruby style guide and best practices
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false

  # RSpec for testing
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 7.1'

  # Environment variable management
  gem 'dotenv-rails'
end

group :development do
  # Interactive console on error pages
  gem 'web-console'
end

group :test do
  # System testing (UI)
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'selenium-webdriver', '>= 4.11.0'
  gem 'shoulda-matchers', '~> 6.4' # For easy model validations ;)
end

gem 'cssbundling-rails', '~> 1.4'
