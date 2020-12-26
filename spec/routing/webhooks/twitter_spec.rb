# frozen_string_literal: true

require 'rails_helper'

describe 'webhooks/twitter', type: :routing do
  describe 'routing' do
    it 'routes to #webhook_challenge' do
      expect(get: '/webhooks/twitter').to route_to(
        controller: 'webhooks/twitter',
        action: 'webhook_challenge'
      )
    end
  end
end
