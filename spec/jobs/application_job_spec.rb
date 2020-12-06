# frozen_string_literal: true

require 'rails_helper'

describe ApplicationJob do
  it 'must inherits ActiveJob Base' do
    expect(described_class).to be < ActiveJob::Base
  end
end
