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
        origins 'http://localhost:4000', \
        # Allow Netlify draft URLs
        /https:\/\/(\w+--)?heyzec-cvwo.netlify.app/, \
        /http:\/\/192\.168\.1\.\d+:\d+/
          
        resource '*', :headers => :any, :methods => [:get, :post, :delete, :patch, :options], :credentials => true
      end
    end

  end
end
