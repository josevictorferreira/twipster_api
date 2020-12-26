# frozen_string_literal: true

require 'rails_helper'

describe Twitter::ChallengeResponseCheckService do
  subject(:service) { described_class.new(crc_token) }

  let(:crc_token) { 'foo' }

  before do
    allow(ENV).to receive(:fetch).with('TWITTER_CONSUMER_SECRET', nil).and_return(consumer_secret)
  end

  context 'when success' do
    let(:consumer_secret) { 'secret' }

    let(:expected_response) { 'sha256=dzukRpPHVT1u4g9h6l0nV6mk9KRNKEGuTpW1LkzWLbQ=' }

    it { expect(service.perform).to be_success }

    it { expect(service.perform.response_token).to include(expected_response) }
  end

  context 'when failure' do
    let(:consumer_secret) { nil }

    it { expect(service.perform).to be_a_failure }
  end
end
