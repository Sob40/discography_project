# frozen_string_literal: true

class Artist < ApplicationRecord
  has_many :lps, dependent: :destroy

  before_validation :normalize_name

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :normalized_name, presence: true, uniqueness: true

  scope :by_name, lambda { |name|
    where('normalized_name LIKE ?', "%#{I18n.transliterate(name).downcase}%")
  }
  scope :ordered, -> { order(:name) }

  def lp_count
    lps.count
  end

  private

  def normalize_name
    self.normalized_name = I18n.transliterate(name).downcase if name.present?
  end
end
