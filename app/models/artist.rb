# frozen_string_literal: true

class Artist < ApplicationRecord
  has_many :lps, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
