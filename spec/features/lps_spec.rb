# frozen_string_literal: true

require 'rails_helper'
require 'cgi'

RSpec.describe 'LP Management', type: :system do
  let!(:artist) { create(:artist, name: 'The Beatles', description: 'Legendary band') }
  let!(:author) { create(:author, name: 'John Lennon') }
  let!(:lp) { create(:lp, name: 'Abbey Road', description: 'Classic album', artist: artist) }

  before do
    driven_by(:rack_test)
  end

  it 'allows viewing the LP index' do
    visit lps_path
    expect(page).to have_content('LPs')
    expect(page).to have_content('Abbey Road')
  end

  it 'allows creating a new LP without nested songs' do
    visit lps_path
    click_on 'New LP'
    fill_in 'LP Name *', with: 'Let It Be'
    fill_in 'Description', with: 'Final album'
    select 'The Beatles', from: 'Artist'
    click_on 'Create'
    expect(page).to have_content('Let It Be')
  end

  it 'allows editing an LP' do
    visit lp_path(lp)
    click_on 'Edit'
    fill_in 'LP Name *', with: 'Revolver'
    click_on 'Update'
    expect(page).to have_content('Revolver')
  end

  it 'allows deleting an LP' do
    visit lp_path(lp)
    click_on 'Delete'
    expect(page).to have_content('LPs')
    expect(page).to have_no_content('Abbey Road')
  end

  context 'with nested songs', :js do
    before do
      driven_by(:selenium_chrome_headless)
    end

    def create_lp_with_songs(lp_name:, description:, songs:)
      visit lps_path
      click_on 'New LP'
      fill_in 'LP Name *', with: lp_name
      fill_in 'Description', with: description
      select 'The Beatles', from: 'Artist'

      songs.each do |song|
        click_on 'Add Song'
        using_wait_time(10) do
          within all('.nested-field').last do
            find("input[placeholder='Enter song name']", visible: :all).set(song[:name]) if song[:name]
            if song[:author]
              db_author = Author.find_by(name: song[:author])
              select_field = find('select.author-select', visible: :all)
              page.execute_script(<<~JS, select_field.native, db_author.id)
                var option = arguments[0].querySelector("option[value='" + arguments[1] + "']");
                if (option) { option.selected = true; }
                var event = new Event('change', { bubbles: true });
                arguments[0].dispatchEvent(event);
              JS
            end
          end
        end
      end

      click_on 'Create'
    end

    def remove_nested_song(song_name)
      click_on 'Edit'
      field = all('.nested-field').find do |nested_field|
        nested_field.find("input[placeholder='Enter song name']", visible: :all).value == song_name
      end
      within(field) do
        click_on 'Remove'
      end
      click_on 'Update'
    end

    it 'allows creating a new LP with nested songs' do
      create_lp_with_songs(
        lp_name: 'Let It Be',
        description: 'Final album',
        songs: [{ name: 'Across the Universe', author: 'John Lennon' }]
      )
      expect(page).to have_content('Let It Be')
      expect(page).to have_content('Across the Universe')
    end

    it 'allows deleting a nested song from an LP' do
      create_lp_with_songs(
        lp_name: 'Let It Be',
        description: 'Final album',
        songs: [{ name: 'Song One' }, { name: 'Song Two' }]
      )
      expect(page).to have_content('Let It Be')
      expect(page).to have_content('Song One')
      expect(page).to have_content('Song Two')

      remove_nested_song('Song One')
      expect(page).to have_content('Let It Be')
      expect(page).to have_no_selector('.nested-field input.song-name-input', text: 'Song One')
      expect(page).to have_content('Song Two')
    end
  end
end
