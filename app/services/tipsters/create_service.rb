# frozen_string_literal: true

module Tipsters
  class CreateService < CreateModelService
    def model_key
      :tipster
    end
  end
end
