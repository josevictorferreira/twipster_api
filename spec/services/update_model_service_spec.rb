# frozen_string_literal: true

require 'rails_helper'

describe UpdateModelService do
  subject(:service) { klass.new(model, { name: 'Name' }) }

  let(:klass) do
    Class.new(described_class) do
      def model_key
        :instance_variable
      end
    end
  end
  let(:model) { instance_double('ApplicationRecord') }
  let(:foos) { class_double('ApplicationRecord') }
  let(:service_perform) { service.perform }

  describe '#perform' do
    context 'when model is successfully updated' do
      before do
        allow(model).to receive(:update).and_return true
        service_perform
      end

      it { expect(model).to have_received(:update).once }
      it { expect(service_perform).to be_a_success }
      it { expect(service_perform.instance_variable).to eql model }
    end

    context 'when model fails to be saved' do
      let(:errors) { OpenStruct.new({ full_messages: ['error'] }) }

      before do
        allow(model).to receive(:update).and_return false
        allow(model).to receive(:errors).and_return errors
        service_perform
      end

      it { expect(model).to have_received(:update).once }
      it { expect(model).to have_received(:errors).once }
      it { expect(service_perform).to be_a_failure }
      it { expect(service_perform.instance_variable).to eql model }
      it { expect(service_perform.details).to eql 'error' }
    end
  end
end
