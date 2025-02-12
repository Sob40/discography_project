# frozen_string_literal: true

class Authorship < ApplicationRecord
  belongs_to :author
  belongs_to :song

  validates :author_id, uniqueness: { scope: :song_id }
end
