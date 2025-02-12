# frozen_string_literal: true

class AddNormalizedNameToArtists < ActiveRecord::Migration[8.0]
  def change
    add_column :artists, :normalized_name, :string
    add_index :artists, :normalized_name, unique: true
  end
end
