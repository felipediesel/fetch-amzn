require 'rails_helper'

RSpec.describe Rank, type: :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:category) }

  it { is_expected.to validate_numericality_of(:position).only_integer.is_greater_than(0) }

  describe 'categories' do
    it 'returns the category tree' do
      parent = Category.create! name: 'Baby Products'
      category = Category.create! name: 'Teethers', parent: parent
      expected_categories = [parent, category]

      rank = Rank.new category: category
      expect(rank.categories).to eq(expected_categories)
    end
  end
end
