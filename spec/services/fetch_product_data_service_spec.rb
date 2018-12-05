require 'rails_helper'

RSpec.describe FetchProductDataService, type: :model do
  let(:product) { Product.create!(asin: 'B002QYW8LW') }
  let(:html) { File.open(Rails.root.join('spec', 'fixtures', 'B002QYW8LW')).read }

  before do
    allow(FetchPageService).to receive(:new).and_return(double('FetchPageService', html: html))
  end

  subject { described_class.new(product) }

  describe '#call' do
    it 'updates product dimensions' do
      expected_dimensions = '4.3 x 0.4 x 7.9 inches'
      subject.call
      expect(product.reload.dimensions).to eq(expected_dimensions)
    end

    it 'updates product state to "ready"' do
      subject.call
      expect(product.reload.state).to eq("ready")
    end

    it 'updates product category' do
      expected_category_name = 'Teethers'
      subject.call
      expect(product.reload.category.name).to eq(expected_category_name)
    end

    it 'create ranks for the product' do
      expected_ranks = [
        [ 1_348, 'Baby'],
        [ 63, 'Teethers'],
        [ 137, 'Health']
      ]

      subject.call
      expect(product.reload.ranks.joins(:category).pluck(:position, 'categories.name')).to include(*expected_ranks)
    end
  end
end
