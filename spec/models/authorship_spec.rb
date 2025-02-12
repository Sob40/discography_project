# frozen_string_literal: true

RSpec.describe Authorship do
  let(:author) { create(:author) }
  let(:song) { create(:song) }
  let!(:authorship) { create(:authorship, author: author, song: song) }

  it 'has a valid authorship' do
    expect(authorship).to be_valid
  end

  it { should belong_to(:author) }
  it { should belong_to(:song) }
  it { should validate_uniqueness_of(:author_id).scoped_to(:song_id) }
end
