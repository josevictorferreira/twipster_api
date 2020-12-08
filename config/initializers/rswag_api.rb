# frozen_string_literal: true

Rswag::Api.configure do |c|
  c.swagger_root = Rails.root.to_s + '/swagger'

  c.swagger_filter = lambda { |swagger, env| swagger['host'] = env['HTTP_HOST'] }
end
