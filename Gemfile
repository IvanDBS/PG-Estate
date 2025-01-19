source "https://rubygems.org"

# Core
gem "rails", "~> 7.1.5"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 6.0"
gem "sassc-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# Frontend
gem "bootstrap", "~> 5.3.2"

# Authentication
gem "devise"

# File Storage
gem "aws-sdk-s3", require: false
gem "active_storage_validations"
gem "image_processing", "~> 1.2"
gem "mini_magick", "~> 4.12"

# Pagination
gem "pagy"
gem "ransack"

# Performance
gem "rack-attack"
gem "secure_headers"

# Monitoring
gem "rack-mini-profiler"

# Internationalization
gem "rails-i18n"

# Error tracking
gem "better_errors"
gem "binding_of_caller"

# File uploads
gem 'carrierwave', '~> 3.0'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-factory_bot", require: false
  gem "bullet"
end
