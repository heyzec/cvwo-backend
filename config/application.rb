require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CvwoBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.middleware.insert_before 0, Rack::Cors do
    allow do
      # origins 'https://heyzec-cvwo.netlify.app', 'http://localhost:3000'
      origins 'http://localhost:3000', /https:\/\/(\w+--)?heyzec-cvwo.netlify.app/  # Allow Netlify draft URLs
      resource '*', :headers => :any, :methods => [:get, :post, :delete, :patch, :options]
    end
  end

  end
end
