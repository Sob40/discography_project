# frozen_string_literal: true

FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }
    description { Faker::Lorem.paragraph }
  end
end
