# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Artist Management', type: :system do
  let!(:artist) { create(:artist, name: 'The Beatles', description: 'Legendary band') }

  before { driven_by(:rack_test) }

  it 'allows viewing the artist index' do
    visit artists_path
    expect(page).to have_content('Artists')
    expect(page).to have_content('The Beatles')
  end

  it 'allows creating a new artist' do
    visit artists_path
    click_on 'New Artist'
    fill_in 'Name', with: 'Queen'
    fill_in 'Description', with: 'Rock band'
    click_on 'Create'  # Se busca el botón con el texto "Create" según la vista

    expect(page).to have_content('Queen')
  end

  it 'allows editing an artist' do
    visit artist_path(artist)
    click_on 'Edit Artist'
    fill_in 'Name', with: 'The Rolling Stones'
    click_on 'Update'  # Se busca el botón con el texto "Update" según la vista

    expect(page).to have_content('The Rolling Stones')
  end

  it 'allows deleting an artist' do
    visit artist_path(artist)
    click_on 'Delete Artist'

    expect(page).to have_content('Artists')
    expect(page).to have_no_content('The Beatles')
  end
end
