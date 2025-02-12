# frozen_string_literal: true

class Lp < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  scope :by_artist_name, lambda { |artist_name|
    joins(:artist).where('artists.normalized_name LIKE ?', "%#{I18n.transliterate(artist_name).downcase}%")
  }
  scope :ordered, -> { order(:name) }
end
