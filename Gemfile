source "https://rubygems.org"

# Rails framework
gem "rails", "~> 8.0.1"

# Modern asset pipeline
gem "propshaft"

# Database (SQLite)
gem "sqlite3", ">= 2.1"

# Recommended web server for Rails
gem "puma", ">= 5.0"

# Import maps for managing JavaScript without Webpacker
gem "importmap-rails"

# Hotwire: Enhances interactivity and application speed
gem "turbo-rails"
gem "stimulus-rails"

# JSON API generator (for future endpoints if needed)
gem "jbuilder"

# Time zone correction for Windows (optional)
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Efficient caching for Rails 8
gem "solid_cache"

# Reduces boot times
gem "bootsnap", require: false

group :development, :test do
  # Rails debugger
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Security analysis for vulnerabilities (optional, but recommended)
  gem "brakeman", require: false

  # Ruby style guide for Rails projects
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Interactive console on error pages
  gem "web-console"
end

group :test do
  # System testing (UI)
  gem "capybara"
  gem "selenium-webdriver"
end

group :development, :test do
  # Environment variable management
  gem "dotenv-rails"
end