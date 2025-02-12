# frozen_string_literal: true

FactoryBot.define do
  factory :lp do
    name { Faker::Music.album }
    description { Faker::Lorem.paragraph }
    artist
  end
end
