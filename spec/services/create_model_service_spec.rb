# frozen_string_literal: true

require 'rails_helper'

describe CreateModelService do
  subject(:service) { klass.new({ name: 'Name' }, scope) }

  let(:klass) do
    Class.new(described_class) do
      def model_key
        :instance_variable
      end
    end
  end
  let(:scope) { class_double('ApplicationRecord') }
  let(:model) { instance_double('ApplicationRecord') }
  let(:foos) { class_double('ApplicationRecord') }
  let(:service_perform) { service.perform }

  describe '#model_key' do
    subject(:service) { described_class.new({ name: 'Name' }, scope) }

    it { expect { service.model_key }.to raise_error(NotImplementedError) }
  end

  describe '#perform' do
    context 'when model is successfully saved with scope' do
      before do
        allow(scope).to receive(:instance_variables).and_return foos
        allow(foos).to receive(:new).and_return model
        allow(model).to receive(:save).and_return true
        service_perform
      end

      it { expect(model).to have_received(:save).once }
      it { expect(service_perform).to be_a_success }
      it { expect(service_perform.instance_variable).to eql model }
      it { expect(service_perform.details).to be_nil }
    end

    context 'when model is successfully saved without scope' do
      subject(:service) { klass.new({ name: 'Name' }) }

      before do
        allow(model).to receive(:save).and_return true
        allow(Object).to receive(:const_get).with('InstanceVariable').and_return(foos)
        allow(foos).to receive(:new).with({ name: 'Name' }).and_return(model)
        service_perform
      end

      it { expect(model).to have_received(:save).once }
      it { expect(service_perform).to be_a_success }
      it { expect(service_perform.instance_variable).to eql model }
      it { expect(service_perform.details).to be_nil }
    end

    context 'when model fails to be saved' do
      let(:errors) { OpenStruct.new({ full_messages: ['error'] }) }

      before do
        allow(scope).to receive(:instance_variables).and_return foos
        allow(foos).to receive(:new).and_return model
        allow(model).to receive(:save).and_return false
        allow(model).to receive(:errors).and_return errors
        service_perform
      end

      it { expect(model).to have_received(:save).once }
      it { expect(model).to have_received(:errors).once }
      it { expect(service_perform).to be_a_failure }
      it { expect(service_perform.instance_variable).to eql model }
      it { expect(service_perform.details).to eql 'error' }
    end
  end
end
