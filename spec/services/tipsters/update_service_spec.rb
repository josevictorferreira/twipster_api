# frozen_string_literal: true

require 'rails_helper'

describe Tipsters::UpdateService do
  subject(:service) { described_class.new(tipster, params) }

  let(:params)          { { name: name, user: user } }
  let(:name)            { FFaker::Name.unique.name }
  let(:user)            { FFaker::Internet.unique.user_name }
  let(:tipster)         { create(:tipster) }
  let(:service_perform) { service.perform }

  context 'when success' do
    before do
      tipster
    end

    it { expect(service_perform).to be_a_success }
    it { expect(service_perform.tipster.name).to eq(name) }
    it { expect(service_perform.tipster.user).to eq(user) }
    it { expect { service_perform }.to change(Tipster, :count).by(0) }
  end

  context 'when error' do
    let(:user) { nil }

    before do
      tipster
    end

    it { expect(service_perform).to be_a_failure }
    it { expect(service_perform.errors).not_to be_nil }
    it { expect { service_perform }.to change(Tipster, :count).by(0) }
  end
end
