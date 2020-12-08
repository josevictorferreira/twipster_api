# frozen_string_literal: true

module Api
  module V1
    class TipstersController < ApplicationController
      before_action :set_tipster, only: %i[show update destroy]

      def index
        @tipsters = Tipster.all

        render json: @tipsters, each_serializer: serializer
      end

      def show
        render json: @tipster, serializer: serializer
      end

      def create
        Tipsters::CreateService.perform!(tipster_params).yield_self do |service|
          if service.success?
            render json: service.tipster,
                   status: :created,
                   serializer: serializer
          else
            render json: service.errors, status: :unprocessable_entity
          end
        end
      end

      def update
        Tipsters::UpdateService.perform!(@tipster, tipster_params).yield_self do |service|
          if service.success?
            render json: service.tipster,
                   status: :ok,
                   serializer: serializer
          else
            render json: service.errors, status: :unprocessable_entity
          end
        end
      end

      def destroy
        @tipster.destroy
      end

      private

      def serializer
        ::Api::V1::TipsterSerializer
      end

      def set_tipster
        @tipster = Tipster.find(params[:id])
      end

      def tipster_params
        params.require(:tipster).permit(:name, :user)
      end
    end
  end
end
