# frozen_string_literal: true

require 'rails_helper'

describe TweetTipsPredictor::PredictService do
  subject(:service) { described_class.new(text, tipster) }

  let(:client) { instance_double(TweetPredictor::Client) }
  let(:text)    { 'Toronto Raptor Over 110' }
  let(:tipster) { 'NBA Tipster' }

  before do
    allow(TweetPredictor::Client).to receive(:new).and_return(client)
  end

  context 'when sucess' do
    let(:expected_api_response) do
      {
        'result': true,
        'status': 200
      }
    end

    before do
      allow(client).to receive(:predict).with(text, tipster).and_return(expected_api_response)
    end

    it { expect(service.perform).to be_success }
    it { expect(service.perform.is_tip).to be_truthy }
  end

  context 'when error' do
    let(:error_message) { 'Failure on API' }

    before do
      allow(client).to receive(:predict).with(text, tipster).and_raise(StandardError.new(error_message))
    end

    it { expect(service.perform).to be_a_failure }
    it { expect(service.perform.errors).to include(error_message) }
  end
end
