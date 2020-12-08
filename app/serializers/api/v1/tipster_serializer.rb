# frozen_string_literal: true

module Api
  module V1
    class TipsterSerializer < ApplicationSerializer
      attributes :name,
                 :user
    end
  end
end
