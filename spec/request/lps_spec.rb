# frozen_string_literal: true

require 'rails_helper'
require 'cgi'

RSpec.describe 'LPs', type: :request do
  let(:artist) { create(:artist, name: 'The Beatles', description: 'Legendary band') }
  let!(:lp) { create(:lp, name: 'Abbey Road', description: 'Classic album', artist: artist) }

  describe 'GET /lps' do
    context 'without search parameter' do
      it 'renders the index page with all LPs' do
        get lps_path
        expect(response).to have_http_status(:ok)
        body = CGI.unescapeHTML(response.body)
        expect(body).to include('Abbey Road')
      end
    end

    context 'with search parameter' do
      let(:queen_artist) { create(:artist, name: 'Queen', description: 'Rock band') }

      before do
        create(:lp, name: 'A Night at the Opera', description: 'Great album', artist: queen_artist)
      end

      it 'filters LPs by artist name ignoring case and accents' do
        get lps_path, params: { artist: 'queen' }
        body = CGI.unescapeHTML(response.body)
        aggregate_failures do
          expect(body).to include('A Night at the Opera')
          expect(body).not_to include('Abbey Road')
        end
      end
    end

    context 'when no LP matches' do
      it 'shows a message indicating no LPs were found' do
        get lps_path, params: { artist: 'nonexistent' }
        expect(response.body).to include('No LPs found')
      end
    end
  end

  describe 'GET /lps/:id' do
    context 'with songs' do
      before do
        create(:song, name: 'Come Together', lp: lp)
        create(:song, name: 'Something', lp: lp)
      end

      it 'renders the LP show page with songs listed' do
        get lp_path(lp)
        expect(response).to have_http_status(:ok)
        body = CGI.unescapeHTML(response.body)
        aggregate_failures do
          expect(body).to include('Come Together')
          expect(body).to include('Something')
        end
      end
    end

    context 'without songs' do
      it 'renders the LP show page without songs' do
        get lp_path(lp)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Abbey Road')
      end
    end
  end

  describe 'POST /lps' do
    context 'without nested songs' do
      it 'creates a new LP' do
        lp_params = {
          name: 'Let It Be',
          description: 'Final album',
          artist_id: artist.id
        }
        expect do
          post lps_path, params: { lp: lp_params }
        end.to change(Lp, :count).by(1)

        new_lp = Lp.find_by(name: 'Let It Be')
        expect(response).to redirect_to(lp_path(new_lp))
        follow_redirect!
        expect(response.body).to include('Let It Be')
      end
    end

    context 'with nested songs' do
      it 'creates a new LP with songs' do
        lp_params = {
          name: 'Let It Be',
          description: 'Final album',
          artist_id: artist.id,
          songs_attributes: {
            '0' => { name: 'Across the Universe' },
            '1' => { name: 'Let It Be Song' }
          }
        }
        expect do
          post lps_path, params: { lp: lp_params }
        end.to change(Lp, :count).by(1)

        new_lp = Lp.find_by(name: 'Let It Be')
        expect(new_lp.songs.count).to eq(2)
      end
    end
  end

  describe 'PUT /lps/:id' do
    it 'updates an LP' do
      put lp_path(lp), params: { lp: { name: 'Revolver' } }
      expect(response).to redirect_to(lp)
      follow_redirect!
      expect(response.body).to include('Revolver')
    end
  end

  describe 'DELETE /lps/:id' do
    it 'deletes an LP' do
      expect do
        delete lp_path(lp)
      end.to change(Lp, :count).by(-1)
      expect(response).to redirect_to(lps_path)
    end
  end
end
