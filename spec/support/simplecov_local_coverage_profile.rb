# frozen_string_literal: true

require 'simplecov'

SimpleCov.profiles.define 'local_coverage' do
  load_profile 'rails'

  add_filter do |source_file|
    source_file.lines.count < 5
  end

  add_filter '/lib/tasks'
  add_filter 'app/constraints'

  add_group 'Services', 'app/services'
  add_group 'Queries', 'app/queries'
  add_group 'Repositories', 'app/repositories'
  add_group 'Serializers', 'app/serializers'
  add_group 'Decorators', 'app/decorators'
  add_group 'Channels', 'app/channels'
end
