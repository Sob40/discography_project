# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author do
  subject { create(:author, name: 'Mr. Arlie Robel') }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
end
