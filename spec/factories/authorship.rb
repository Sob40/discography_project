# frozen_string_literal: true

FactoryBot.define do
  factory :authorship do
    author
    song
  end
end
