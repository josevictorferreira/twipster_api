# frozen_string_literal: true

module TweetPredictor
  class Client
    API_ENDPOINT = ENV.fetch('TWEET_PREDICTOR_URL', 'http://localhost:5000')

    def predict(text, tipster)
      request(
        http_method: :post,
        endpoint: '/predict',
        params: { 'text': text, 'tipster': tipster }
      )
    end

    private

    def request(http_method:, endpoint:, params: {})
      response = client.public_send(http_method, endpoint, params.to_json)
      parsed_response = JSON.parse(response.body)

      return parsed_response if response.status == 200 || response.status == 201

      raise StandardError, "Code: #{response.status}, response: #{response.body}"
    end

    def client
      @client ||= Faraday.new(API_ENDPOINT) do |client|
        client.request :url_encoded
        client.adapter :typhoeus
        client.headers = headers
      end
    end

    def headers
      @headers ||= {
        'Content-Type': 'application/json'
      }
    end
  end
end
