# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Song do
  it { should belong_to(:lp) }
  it { should validate_presence_of(:name) }
end
