require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module GekkoSaas
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w[assets tasks])

    config.time_zone = "Central America"
    config.active_record.default_timezone = :utc

    config.i18n.default_locale = :es
    config.i18n.available_locales = [:es, :en]
  end
end
