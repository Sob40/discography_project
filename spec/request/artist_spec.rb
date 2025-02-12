# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Artists', type: :request do
  let!(:artist) { create(:artist, name: 'The Beatles', description: 'Legendary band') }

  describe 'GET /artists' do
    it 'renders the index page' do
      get artists_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Artists')
    end
  end

  describe 'GET /artists/:id' do
    it 'renders the artist show page' do
      get artist_path(artist)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('The Beatles')
    end
  end

  describe 'POST /artists' do
    it 'creates a new artist' do
      expect do
        post artists_path, params: { artist: { name: 'Queen', description: 'Rock band' } }
      end.to change(Artist, :count).by(1)

      new_artist = Artist.find_by(name: 'Queen')
      expect(response).to redirect_to(artist_path(new_artist))
      follow_redirect!
      expect(response.body).to include('Queen')
    end
  end

  describe 'PUT /artists/:id' do
    it 'updates an artist' do
      put artist_path(artist), params: { artist: { name: 'The Rolling Stones' } }
      expect(response).to redirect_to(artist)
      follow_redirect!
      expect(response.body).to include('The Rolling Stones')
    end
  end

  describe 'DELETE /artists/:id' do
    it 'deletes an artist' do
      expect do
        delete artist_path(artist)
      end.to change(Artist, :count).by(-1)

      expect(response).to redirect_to(artists_path)
    end
  end
end
