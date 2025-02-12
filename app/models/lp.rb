# frozen_string_literal: true

class Lp < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true

  scope :by_artist_name, lambda { |artist_name|
    normalized_artist_name = I18n.transliterate(artist_name).downcase
    joins(:artist).where('LOWER(artists.normalized_name) LIKE ?', "%#{normalized_artist_name}%")
  }
  scope :ordered, -> { order(:name) }
end
