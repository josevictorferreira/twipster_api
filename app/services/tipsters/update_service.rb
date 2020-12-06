# frozen_string_literal: true

module Tipsters
  class UpdateService < UpdateModelService
    def model_key
      :tipster
    end
  end
end
