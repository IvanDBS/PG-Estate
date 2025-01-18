source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Core gems
gem "rails", "~> 7.1.2"
gem "pg", "~> 1.1"
gem "puma", "~> 5.6"
gem "sprockets-rails"

# Frontend
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem 'bootstrap', '~> 5.3.2'
gem 'jquery-rails'
gem "sassc-rails"

# Authentication & Authorization
gem 'devise', '~> 4.9.4'
gem 'pundit'

# File handling
gem 'active_storage_validations'
gem "aws-sdk-s3", require: false
gem "image_processing", "~> 1.0"
gem "mini_magick"

# Pagination & Search
gem 'pagy', '~> 6.0'
gem 'ransack'

# Performance & Monitoring
gem "bootsnap", require: false
gem 'rack-mini-profiler'
gem 'memory_profiler'
gem 'stackprof'

# API building
gem "jbuilder"

# Security
gem 'rack-attack'
gem 'secure_headers'

# Internationalization
gem "rails-i18n"

# Error tracking
gem 'exception_notification'

# Background jobs
gem 'sidekiq'

# Development and testing gems
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem "web-console"
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]