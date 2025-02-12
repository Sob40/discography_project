# frozen_string_literal: true

FactoryBot.define do
  factory :song do
    name { Faker::Music::RockBand.song }
    lp
  end
end
