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
      let(:artist2) { create(:artist, name: 'Queen', description: 'Rock band') }

      # Línea en blanco añadida después del último let
      before { create(:lp, name: 'A Night at the Opera', description: 'Great album', artist: artist2) }

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
    it 'renders the LP show page' do
      get lp_path(lp)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Abbey Road')
      expect(response.body).to include('The Beatles')
    end
  end

  describe 'POST /lps' do
    it 'creates a new LP' do
      expect do
        post lps_path, params: { lp: { name: 'Let It Be', description: 'Final album', artist_id: artist.id } }
      end.to change(Lp, :count).by(1)

      new_lp = Lp.find_by(name: 'Let It Be')
      expect(response).to redirect_to(lp_path(new_lp))
      follow_redirect!
      expect(response.body).to include('Let It Be')
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
