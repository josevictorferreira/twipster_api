# frozen_string_literal: true

require 'rails_helper'

describe 'GET /webhooks/twitter', type: :request do
  subject(:get_request) do
    get webhooks_twitter_path,
        params: params
  end

  let(:params) { { crc_token: 'foo' } }
  let(:json_response) { JSON.parse(response.body) }

  before do
    allow(ENV).to receive(:fetch).with('TWITTER_CONSUMER_SECRET', nil).and_return(consumer_secret)
    get_request
  end

  context 'when success' do
    let(:consumer_secret) { 'secret' }
    let(:expected_response) { 'sha256=dzukRpPHVT1u4g9h6l0nV6mk9KRNKEGuTpW1LkzWLbQ=' }

    it { expect(response).to have_http_status(:ok) }
    it { expect(json_response['response_token']).to eq(expected_response) }
  end

  context 'when failure' do
    let(:consumer_secret) { nil }
    let(:expected_response) { ['Twitter Consumer Key not found'] }

    it { expect(response).to have_http_status(:unprocessable_entity) }
    it { expect(json_response).to eq(expected_response) }
  end
end
