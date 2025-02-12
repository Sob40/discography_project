# frozen_string_literal: true

require 'rails_helper'
require 'cgi'

RSpec.describe 'LPs Filtering', type: :request do
  before do
    grace = create(:artist, name: 'Grace Jones', description: 'Iconic artist')
    guns  = create(:artist, name: "Guns N' Roses", description: 'Legendary rock band')
    create(:lp, name: 'Grace Album', description: 'Album by Grace Jones', artist: grace)
    create(:lp, name: 'Guns Album', description: 'Album by Guns N\' Roses', artist: guns)
  end

  describe 'GET /lps' do
    context 'without search parameter' do
      it 'displays all LPs' do
        get lps_path
        body = CGI.unescapeHTML(response.body)
        expect(body).to include('Grace Album')
        expect(body).to include('Guns Album')
      end
    end

    context 'with search parameter' do
      it 'filters LPs by artist name ignoring case and accents' do
        get lps_path, params: { artist: 'grace' }
        body = CGI.unescapeHTML(response.body)
        aggregate_failures do
          expect(body).to include('Grace Album')
          expect(body).not_to include('Guns Album')
        end
      end
    end

    context 'when no LP matches' do
      it 'shows a message indicating no LPs were found' do
        get lps_path, params: { artist: 'nonexistent' }
        expect(response.body).to include('No LPs found')
      end
    end

    context 'con parámetro de búsqueda con acentos' do
      it 'filtra LPs ignorando los acentos en el nombre del artista' do
        get lps_path, params: { artist: 'gráce' }
        body = CGI.unescapeHTML(response.body)
        aggregate_failures do
          expect(body).to include('Grace Album')
          expect(body).not_to include('Guns Album')
        end
      end
    end
  end
end
