# frozen_string_literal: true

module Twitter
  class ChallengeResponseCheckService < Aldous::Service
    attr_reader :crc_token

    def initialize(crc_token)
      @crc_token = crc_token
      super()
    end

    def perform
      if consumer_secret.present?
        Result::Success.new(response_token: generate_crc_response(consumer_secret, crc_token))
      else
        Result::Failure.new(errors: ['Twitter Consumer Key not found'])
      end
    end

    private

    def generate_crc_response(secret, token)
      "sha256=#{encode_hash(generate_hash(secret, token))}"
    end

    def encode_hash(hash)
      Base64.encode64(hash).strip!
    end

    def generate_hash(secret, token)
      OpenSSL::HMAC.digest('sha256', secret, token)
    end

    def consumer_secret
      @consumer_secret ||= ENV.fetch('TWITTER_CONSUMER_SECRET', nil)
    end
  end
end
