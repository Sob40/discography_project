# frozen_string_literal: true

class Lp < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
