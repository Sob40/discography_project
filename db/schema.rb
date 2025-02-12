# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_12_085716) do
  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "LOWER(name)", name: "index_artists_on_LOWER_name", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "LOWER(name)", name: "index_authors_on_LOWER_name", unique: true
  end

  create_table "authorships", force: :cascade do |t|
    t.integer "author_id", null: false
    t.integer "song_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id", "song_id"], name: "index_authorships_on_author_id_and_song_id", unique: true
    t.index ["author_id"], name: "index_authorships_on_author_id"
    t.index ["song_id"], name: "index_authorships_on_song_id"
  end

  create_table "lps", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "LOWER(name)", name: "index_lps_on_LOWER_name", unique: true
    t.index ["artist_id"], name: "index_lps_on_artist_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "name", null: false
    t.integer "lp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lp_id"], name: "index_songs_on_lp_id"
  end

  add_foreign_key "authorships", "authors"
  add_foreign_key "authorships", "songs"
  add_foreign_key "lps", "artists"
  add_foreign_key "songs", "lps"
end
