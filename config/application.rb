require_relative 'boot'

require "rails"
require "active_model_serializers"
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module TwipsterApi
  class Application < Rails::Application
    config.load_defaults 6.0

    config.api_only = true

    config.autoload_paths += %W(
      #{config.root}/app/services
    )

    config.eager_load_paths << "#{Rails.root}/lib"
    config.eager_load_paths += %W(
      #{config.root}/app/services
    )
  end
end
