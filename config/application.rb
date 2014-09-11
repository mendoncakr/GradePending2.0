require File.expand_path('../boot', __FILE__)
# require File.expand_path('../lib/rack/health')
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GradePending
  class Application < Rails::Application

    #compresses HTML, JSON and other Rails-generated responses
    config.middleware.use Rack::Deflater
    
    require Rails.root.join('lib/rack-health')
    config.middleware.insert_before Rack::Sendfile, Rack::Health, routes: ['/ping', '/PING'], response: ['PONG']
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
