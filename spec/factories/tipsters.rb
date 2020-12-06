# frozen_string_literal: true

FactoryBot.define do
  factory :tipster do
    name { FFaker::Name.unique.name }
    user { FFaker::Internet.unique.user_name }
  end
end
