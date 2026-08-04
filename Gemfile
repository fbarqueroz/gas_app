source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

gem "rails", "~> 7.1.3"
gem "pg", "~> 1.5"
gem "puma", "~> 6.4"

# Frontend server-driven (sin necesidad de un SPA aparte)
gem "turbo-rails"
gem "stimulus-rails"
gem "importmap-rails"
gem "tailwindcss-rails"

# Autenticación y autorización
gem "devise", "~> 4.9"
gem "pundit", "~> 2.3"

# Multi-tenant sencillo por columna account_id + scoping
gem "acts_as_tenant", "~> 1.0"

# Redis (cache, Turbo Streams, base para Sidekiq)
gem "redis", "~> 5.0"

# Boot / rendimiento
gem "bootsnap", require: false

# Zona horaria / feriados CR (útil para reportes por turno)
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "faker"
  gem "rspec-rails"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

# Jobs en background (listo para activarse en la fase de conciliación Sinpe)
gem "sidekiq", "~> 7.2"
