# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist do
  subject { create(:artist, name: 'Grace Jones') }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
end
