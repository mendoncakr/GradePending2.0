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
  end
end
