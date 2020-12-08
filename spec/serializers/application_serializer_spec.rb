# frozen_string_literal: true

require 'rails_helper'

describe ApplicationSerializer, type: :serializer do
  subject(:application_serialized) { described_class.new(model) }

  let(:model) { build_stubbed(:tipster) }

  describe 'attributes' do
    let(:attributes) { application_serialized.serializable_hash }

    it 'responds to attributes' do
      expect(
        attributes.keys
      ).to contain_exactly(:id, :created_at, :updated_at)
    end
  end
end
