# frozen_string_literal: true

class Song < ApplicationRecord
  belongs_to :lp
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships

  validates :name, presence: true
end
