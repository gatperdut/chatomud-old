require File.expand_path("boot", __dir__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatoMud
  class Application < Rails::Application
    config.chatomud = config_for(:chatomud)

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get, :post, :options]
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Load the /lib folder, where our server lives.
    config.autoload_paths += %W[#{Rails.root}/lib]

    config.eager_load = true

    config.after_initialize do
      if Rails.const_defined?(:Server) && !Rails.env.test?
        require "server"

        Thread.abort_on_exception = true
        Thread.new do
          ::Server = ChatoMud::Server.new
          ::Server.listen
        end
      end
    end
  end
end

APP_CONFIG = Rails.configuration.chatomud

require "realtime"
