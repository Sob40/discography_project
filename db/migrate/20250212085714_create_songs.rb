# frozen_string_literal: true

class CreateSongs < ActiveRecord::Migration[8.0]
  def change
    create_table :songs do |t|
      t.string :name, null: false
      t.references :lp, null: false, foreign_key: true

      t.timestamps
    end
  end
end
