# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'active_model_serializers', '~> 0.10.11'
gem 'aldous', '~> 1.1.3'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'faraday', '~> 1.1.0'
gem 'mongoid', '~> 7.0.5'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'rswag-api', '~> 2.3.1'
gem 'rswag-ui', '~> 2.3.1'
gem 'typhoeus', '~> 1.4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.7.6'
  gem 'factory_bot_rails', '~> 5.0.2'
  gem 'ffaker', '~> 2.17.0'
  gem 'mongoid-rspec', '~> 4.1.0'
  gem 'pry-byebug'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'rswag-specs', '~> 2.3.1'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'simplecov',  '~> 0.20.0'
  gem 'vcr', '~> 6.0.0'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
