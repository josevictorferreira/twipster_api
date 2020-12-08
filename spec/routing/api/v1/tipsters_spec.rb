# frozen_string_literal: true

require 'rails_helper'

describe 'api/v1/tipsters', type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/tipsters').to route_to(
        controller: 'api/v1/tipsters',
        action: 'index'
      )
    end

    it 'does not routes to #show' do
      expect(get: '/api/v1/tipsters/1').to route_to(
        controller: 'api/v1/tipsters',
        action: 'show',
        id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/api/v1/tipsters').to route_to(
        controller: 'api/v1/tipsters',
        action: 'create'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/tipsters/1').to route_to(
        controller: 'api/v1/tipsters',
        action: 'update',
        id: '1'
      )
    end

    it 'does not routes to #destroy' do
      expect(delete: '/api/v1/tipsters/1').to route_to(
        controller: 'api/v1/tipsters',
        action: 'destroy',
        id: '1'
      )
    end
  end
end
