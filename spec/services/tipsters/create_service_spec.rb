# frozen_string_literal: true

require 'rails_helper'

describe Tipsters::CreateService do
  subject(:service) { described_class.new(params) }

  let(:params) { { name: name, user: user } }
  let(:name) { FFaker::Name.unique.name }
  let(:user) { FFaker::Internet.unique.user_name }

  context 'when success' do
    let(:service_perform) { service.perform }

    it { expect(service_perform).to be_a_success }
    it { expect(service_perform.tipster.name).to eq(name) }
    it { expect(service_perform.tipster.user).to eq(user) }
    it { expect { service_perform }.to change(Tipster, :count).by(1) }
  end
end
