# frozen_string_literal: true

# Delete data in reverse order to avoid dependency errors
Authorship.destroy_all
Song.destroy_all
Lp.destroy_all
Author.destroy_all
Artist.destroy_all

# Create artists
heroes = Artist.create!(
  name: 'Héroes del Silencio',
  description: 'Spanish rock band known for their influential role in the Latin rock scene.'
)
extremoduro = Artist.create!(
  name: 'Extremoduro',
  description: 'Spanish hard rock band recognized for their transgressive style.'
)

# Create authors
bumbury = Author.create!(name: 'Enrique Bunbury')
roberto = Author.create!(name: 'Robe Iniesta')

# Create LPs
avalanch = heroes.lps.create!(
  name: 'Avalancha',
  description: 'The fourth and final studio album by Héroes del Silencio, released in 1995. ' \
               'It is considered a turning point in the Rock en Español movement of the 90s.'
)
agila = extremoduro.lps.create!(
  name: 'Agila',
  description: 'The sixth studio album by Extremoduro, released in 1996. ' \
               'It is often considered their breakthrough album.'
)

# Create songs with correct relationships
song1 = Song.create!(name: 'Iberia sumergida', lp: avalanch)
song2 = Song.create!(name: 'So payaso', lp: agila)

# Associate songs with authors (through Authorship)
song1.authors << bumbury
song2.authors << roberto

Rails.logger.debug
