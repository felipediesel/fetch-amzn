require 'rails_helper'

RSpec.describe Rank, type: :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:category) }

  it { is_expected.to validate_numericality_of(:position).only_integer.is_greater_than(0) }
end
