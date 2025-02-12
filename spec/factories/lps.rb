# frozen_string_literal: true

FactoryBot.define do
  factory :lp do
    sequence(:name) { |n| "#{Faker::Music.album} #{n}" }
    description { Faker::Lorem.paragraph }
    artist
  end
end
