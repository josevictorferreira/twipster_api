# frozen_string_literal: true

class UpdateModelService < Aldous::Service
  attr_reader :model, :model_data

  def initialize(model, model_data)
    super()
    @model      = model
    @model_data = model_data
  end

  def perform
    if model.update(model_data)
      Result::Success.new(model_key => model)
    else
      Result::Failure.new(
        model_key => model,
        details: model.errors.full_messages.join(', ')
      )
    end
  end
end
