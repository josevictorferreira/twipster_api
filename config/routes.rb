# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :tipsters
    end
  end
end
