# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :authorships, dependent: :destroy
  has_many :songs, through: :authorships

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
