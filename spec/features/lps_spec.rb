# frozen_string_literal: true

require 'rails_helper'
require 'cgi'

RSpec.describe 'LP Management', type: :system do
  let!(:artist) { create(:artist, name: 'The Beatles', description: 'Legendary band') }
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
    it 'allows creating a new LP with nested songs' do
      driven_by(:selenium_chrome_headless)

      visit lps_path
      click_on 'New LP'
      fill_in 'LP Name *', with: 'Let It Be'
      fill_in 'Description', with: 'Final album'
      select 'The Beatles', from: 'Artist'

      click_on 'Add Song'

      using_wait_time(10) do
        within all('.nested-field').last do
          find("input[placeholder='Enter song name']", visible: :all).set('Across the Universe')
        end
      end

      click_on 'Create'

      expect(page).to have_content('Let It Be')
      expect(page).to have_content('Across the Universe')
    end
  end
end
