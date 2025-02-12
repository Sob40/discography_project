# frozen_string_literal: true

class Lp < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true

  scope :by_artist_name, ->(artist_name) {
    joins(:artist).where("LOWER(artists.name) LIKE ?", "%#{artist_name.downcase}%")
  }
  scope :ordered, -> { order(:name) }
end
