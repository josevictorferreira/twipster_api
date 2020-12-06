# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

SimpleCov.minimum_coverage 99.9
SimpleCov.start 'local_coverage'

RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_active_record = false
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
