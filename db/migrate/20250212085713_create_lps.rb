# frozen_string_literal: true

class CreateLps < ActiveRecord::Migration[8.0]
  def change
    create_table :lps do |t|
      t.string :name, null: false
      t.text :description
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end

    add_index :lps, 'LOWER(name)', unique: true
  end
end
