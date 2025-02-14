# frozen_string_literal: true

# db/seeds.rb
# Delete existing data in reverse order to avoid dependency errors
Authorship.destroy_all
Song.destroy_all
Lp.destroy_all
Author.destroy_all
Artist.destroy_all

# Data for Spanish bands (artists)
artists_data = [
  { name: 'Héroes del Silencio',
    description: 'Legendary Spanish rock band known for their influential role in the Latin rock scene.' },
  { name: 'Extremoduro', description: 'Iconic Spanish hard rock band recognized for their transgressive style.' },
  { name: 'Los Planetas', description: 'Pioneers of Spanish indie pop/rock with a distinctive sound.' },
  { name: 'Fangoria', description: 'Popular Spanish electropop duo.' },
  { name: 'Vetusta Morla', description: 'Spanish alternative rock band known for their creative compositions.' },
  { name: 'Los Rodríguez', description: 'Spanish-Argentine rock band with a blend of rock and flamenco influences.' },
  { name: 'Mägo de Oz', description: 'Folk metal band from Spain that mixes rock with Celtic elements.' },
  { name: 'Estopa', description: 'Spanish rumba rock duo with a raw and energetic style.' },
  { name: 'La Oreja de Van Gogh',
    description: 'Pop band from Spain known for their catchy melodies and relatable lyrics.' },
  { name: 'El Canto del Loco', description: 'Spanish pop rock band that enjoyed massive popularity in the 2000s.' }
]

# Create artists using FactoryBot
artists = artists_data.map do |data|
  FactoryBot.create(:artist, data)
end

# List of author names (varied)
author_names = [
  'Enrique Bunbury', 'Robe Iniesta', 'Javier Molina', 'Mikel Erentxun',
  'Manuel', 'Paco', 'Juan', 'Luis', 'Carlos', 'Ana', 'María', 'Sergio', 'David'
]

# Create authors using FactoryBot
authors = author_names.map do |name|
  FactoryBot.create(:author, name: name)
end

# For each artist, create between 2 and 4 LPs, and for each LP create between 3 and 6 songs.
artists.each do |artist|
  rand(2..4).times do |i|
    lp = FactoryBot.create(:lp,
                           name: "#{artist.name} LP #{i + 1}",
                           description: "This is LP #{i + 1} by #{artist.name}.",
                           artist: artist)
    rand(3..6).times do |j|
      song = FactoryBot.create(:song,
                               name: "Song #{j + 1} from #{lp.name}",
                               lp: lp)
      # Assign between 1 and 3 random authors to each song
      rand(1..3).times do
        random_author = authors.sample
        song.authors << random_author unless song.authors.include?(random_author)
      end
    end
  end
end

Rails.logger.debug do
  "Seeds loaded successfully with #{Artist.count} artists, " \
    "#{Lp.count} LPs, #{Song.count} songs, and #{Author.count} authors."
end
