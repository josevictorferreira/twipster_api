# frozen_string_literal: true

require 'rails_helper'

describe TweetPredictor::Client, :vcr do
  subject(:client) { described_class.new }

  describe '#predict' do
    context 'when sucess' do
      subject(:predict) { client.predict(text, tipster) }

      let(:text) { 'Hello World!' }
      let(:tipster) { 'Random Tipster' }

      it { expect(predict).to be_kind_of(Hash) }
      it { expect(predict).to have_key('result') }
      it { expect(predict['status']).to eq(200) }
    end

    context 'when error' do
      subject(:predict) { client.predict(text, tipster) }

      let(:text) { 1 }
      let(:tipster) { nil }

      it { expect { predict }.to raise_error(StandardError) }
    end
  end
end
