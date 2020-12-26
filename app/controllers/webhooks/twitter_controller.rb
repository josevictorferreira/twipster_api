# frozen_string_literal: true

module Webhooks
  class TwitterController < ApplicationController
    def webhook_challenge
      challenge_service.perform(twitter_params[:crc_token]).yield_self do |result|
        if result.success?
          render json: { response_token: result.response_token },
                 status: :ok
        else
          render json: result.errors, status: :unprocessable_entity
        end
      end
    end

    private

    def challenge_service
      ::Twitter::ChallengeResponseCheckService
    end

    def twitter_params
      params.permit(:crc_token)
    end
  end
end
