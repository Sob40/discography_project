# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist do
  subject { create(:artist, name: 'Grace Jones') }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }

  describe 'methods' do
    let!(:artist) { create(:artist) }

    it 'returns the correct LP count' do
      create_list(:lp, 3, artist: artist)
      expect(artist.lp_count).to eq(3)
    end
  end
end
