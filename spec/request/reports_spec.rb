# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :request do
  describe 'GET /reports' do
    let!(:artist) { create(:artist, name: 'The Beatles', description: 'Legendary band') }
    let!(:lps) do
      [
        create(:lp, name: 'Abbey Road', description: 'Classic album', artist: artist),
        create(:lp, name: 'Let It Be', description: 'Final album', artist: artist)
      ]
    end

    let!(:songs) do
      [
        create(:song, name: 'Come Together', lp: lps.first),
        create(:song, name: 'Something', lp: lps.first),
        create(:song, name: 'Across the Universe', lp: lps.last)
      ]
    end

    let!(:authors) do
      [
        create(:author, name: 'John Lennon'),
        create(:author, name: 'Paul McCartney')
      ]
    end

    before do
      create(:authorship, song: songs[0], author: authors[0])
      create(:authorship, song: songs[0], author: authors[1])
      create(:authorship, song: songs[1], author: authors[0])
      create(:authorship, song: songs[2], author: authors[0])
    end

    it 'returns a successful response and shows correct aggregated data' do
      get reports_path
      expect(response).to have_http_status(:success)
      body = response.body

      expect(body).to include('Abbey Road')
      expect(body).to include('Let It Be')
      expect(body).to include('The Beatles')
      expect(body).to include('2 Songs')
      expect(body).to include('1 Songs')
      expect(body).to match(/(John Lennon.*Paul McCartney)|(Paul McCartney.*John Lennon)/)
      expect(body).to include('John Lennon')
    end
  end
end
