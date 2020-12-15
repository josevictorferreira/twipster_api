# frozen_string_literal: true

module TweetTipsPredictor
  class PredictService < Aldous::Service
    attr_reader :text, :tipster

    def initialize(text, tipster)
      @text = text
      @tipster = tipster
      super()
    end

    def perform
      Result::Success.new(is_tip: result)
    rescue StandardError => e
      failure(e)
    end

    private

    def result
      predict&.symbolize_keys&.[](:result)
    end

    def predict
      @predict ||= client.predict(text, tipster)
    end

    def client
      @client ||= TweetPredictor::Client.new
    end

    def failure(error)
      Result::Failure.new(errors: [error.message])
    end
  end
end
