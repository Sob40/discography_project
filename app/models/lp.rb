# frozen_string_literal: true

class Lp < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy

  accepts_nested_attributes_for :songs, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :artist, presence: { message: I18n.t('errors.messages.artist_required') }

  scope :by_artist_name, lambda { |artist_name|
    normalized_artist_name = I18n.transliterate(artist_name).downcase
    joins(:artist).where('LOWER(artists.normalized_name) LIKE ?', "%#{normalized_artist_name}%")
  }
  scope :ordered, -> { order(:name) }
  scope :with_report_data, lambda {
    left_joins(:songs, :artist)
      .left_joins(songs: :authors)
      .group('lps.id', 'artists.name')
      .select(<<-SQL.squish)
        lps.id,
        lps.name,
        artists.name AS artist_name,
        COUNT(DISTINCT songs.id) AS song_count,
        GROUP_CONCAT(DISTINCT authors.name) AS authors_list
      SQL
  }
end
