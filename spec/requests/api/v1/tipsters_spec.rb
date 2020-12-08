# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Tipsters API', type: :request do
  path '/api/v1/tipsters' do
    get 'List all Tipsters' do
      tags 'Tipsters'

      response '200', 'tipsters listed' do
        let(:tipster) { { name: 'John Doe', user: 'john_doe_tipster' } }
        run_test!
      end
    end

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

  path '/api/v1/tipsters/{id}' do
    get 'Show a tipster' do
      tags 'Tipsters'
      consumes 'application/json'
      parameter name: :id, in: :path, schema: { type: :string }

      response '200', 'show tipster' do
        let(:id) { create(:tipster).id }
        run_test!
      end
    end

    put 'Updates a tipster' do
      tags 'Tipsters'
      consumes 'application/json'
      parameter name: :id, in: :path, schema: { type: :string }
      parameter name: :tipster, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'John Doe' },
          user: { type: :string, example: 'john_doe' }
        }
      }

      response '200', 'tipster updated' do
        let(:id) { create(:tipster).id }
        let(:tipster) { { name: 'John Doe', user: 'john_doe_tipster' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:tipster).id }
        let(:tipster) { { name: nil } }
        run_test!
      end
    end

    delete 'Show a tipster' do
      tags 'Tipsters'
      consumes 'application/json'
      parameter name: :id, in: :path, schema: { type: :string }

      response '204', 'tipster deleted' do
        let(:id) { create(:tipster).id }
        run_test!
      end
    end
  end
end
