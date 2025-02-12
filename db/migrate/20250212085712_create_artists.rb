# frozen_string_literal: true

class CreateArtists < ActiveRecord::Migration[8.0]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_index :artists, 'LOWER(name)', unique: true
  end
end
