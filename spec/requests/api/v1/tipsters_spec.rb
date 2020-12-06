# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Tipsters API', type: :request do
  path '/api/v1/tipsters' do
    post 'Creates a Tipster' do
      tags 'Tipsters'
      consumes 'application/json'
      parameter name: :tipster, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'John Doe' },
          user: { type: :string, example: 'john_doe' }
        },
        required: %w[name user]
      }

      response '201', 'tipster created' do
        let(:tipster) { { name: 'John Doe', user: 'john_doe_tipster' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:tipster) { { name: 'John Doe' } }
        run_test!
      end
    end
  end
end
