require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to have_many(:ranks).dependent(:destroy) }
  it { is_expected.to belong_to(:category) }

  it { is_expected.to validate_presence_of(:asin) }

  describe 'categories' do
    context 'when the product has a category' do
      it 'returns the category tree' do
        parent = Category.create! name: 'Baby Products'
        category = Category.create! name: 'Teethers', parent: parent
        expected_categories = [parent, category]

        product = Product.new category: category
        expect(product.categories).to eq(expected_categories)
      end
    end
    context 'when the product has no category' do
      it 'returns an empty array' do
        product = Product.new
        expect(product.categories).to eq([])
      end
    end
  end
end
