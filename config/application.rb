require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DiscographyProject
  class Application < Rails::Application
    # Initialize configuration defaults for the originally generated Rails version.
    config.load_defaults 8.0

    # Autoload only necessary folders in lib
    config.autoload_lib(ignore: %w[assets tasks])

    # Time zone configuration for Spain
    config.time_zone = "Europe/Madrid" # Change to "Atlantic/Canary" if you're in the Canary Islands
    config.active_record.default_timezone = :local

    # Load environment variables in development and test
    require 'dotenv/load' if Rails.env.development? || Rails.env.test?

    # Add additional eager load paths if necessary
    # config.eager_load_paths << Rails.root.join("extras")
  end
end