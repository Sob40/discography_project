# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lp do
  subject { create(:lp, name: 'Midnight Memories') }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should belong_to(:artist) }
  it { should have_many(:songs).dependent(:destroy) }
end
