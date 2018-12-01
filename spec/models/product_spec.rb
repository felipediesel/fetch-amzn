require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to have_many(:ranks).dependent(:destroy) }
  it { is_expected.to belong_to(:category) }

  it { is_expected.to validate_presence_of(:asin) }
end
