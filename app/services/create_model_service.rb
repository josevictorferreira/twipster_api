# frozen_string_literal: true

class CreateModelService < Aldous::Service
  attr_reader :data, :scope

  def initialize(data, scope = nil)
    super()
    @data  = data
    @scope = scope
  end

  def perform
    if model.save
      model_creation_callback.call
      Result::Success.new(model_key => model, details: nil)
    else
      model_failure_callback.call
      Result::Failure.new(
        model_key => model,
        details: model.errors.full_messages.join(', ')
      )
    end
  end

  def model_key
    raise NotImplementedError
  end

  private

  def model
    @model ||= model_object
  end

  def model_object
    return scope.public_send(model_key.to_s.pluralize).new(data) if scope.present?

    Object.const_get(model_key.to_s.classify).new(data)
  end

  def model_creation_callback
    -> {}
  end

  def model_failure_callback
    -> {}
  end
end
