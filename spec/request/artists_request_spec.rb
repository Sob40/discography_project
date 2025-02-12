# frozen_string_literal: true

require 'rails_helper'
require 'cgi'

RSpec.describe 'Artists', type: :request do
  before do
    create(:artist, name: 'Grace Jones')
    create(:artist, name: "Guns N' Roses")
  end

  describe 'GET /artists' do
    context 'without search parameter' do
      it 'displays all artists' do
        get artists_path
        expect(CGI.unescapeHTML(response.body)).to include("Guns N' Roses")
      end
    end

    context 'with search parameter' do
      it 'filters artists by name ignoring case and accents' do
        get artists_path, params: { search: 'grace' }
        aggregate_failures do
          expect(CGI.unescapeHTML(response.body)).to include('Grace Jones')
          expect(CGI.unescapeHTML(response.body)).not_to include("Guns N' Roses")
        end
      end
    end

    context 'when no artist matches' do
      it 'shows a message indicating no artists were found' do
        get artists_path, params: { search: 'nonexistent' }
        expect(response.body).to include('No artists found')
      end
    end
  end
end
