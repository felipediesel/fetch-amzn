require 'rails_helper'

RSpec.describe ParsePageService, type: :model do
  let(:html) { File.open(Rails.root.join('spec', 'fixtures', 'B002QYW8LW')).read }
  let(:empty_html) { "<body></body>" }

  subject { described_class.new(html) }

  describe '#dimensions' do
    it 'fetches the dimensions from the html' do
      expect(subject.dimensions).to eq('4.3 x 0.4 x 7.9 inches')
    end

    context 'when dimensions are not available on the HTML' do
      let(:html) { empty_html }

      it 'returns an empty string' do
        expect(subject.dimensions).to be_a(String)
        expect(subject.dimensions).to be_empty
      end
    end
  end

  describe '#ranking' do
    it 'fetches the ranking from the html' do
      expected_ranking = [
        { position: 1_348, categories: ['Baby'] },
        { position: 63, categories: ['Baby', 'Baby Care', 'Pacifiers, Teethers & Teething Relief', 'Teethers'] },
        { position: 137, categories: ['Baby', 'Baby Care', 'Health'] }
      ]

      expect(subject.ranking).to eq(expected_ranking)
    end

    context 'when ranking is not available on the HTML' do
      let(:html) { empty_html }

      it 'returns an empty string' do
        expect(subject.ranking).to be_an(Array)
        expect(subject.ranking).to  be_empty
      end
    end
  end

  describe '#categories' do
    it 'fetches categories from the html' do
      expected_categories = ['Baby Products', 'Baby Care', 'Pacifiers, Teethers & Teething Relief', 'Teethers']

      expect(subject.categories).to eq(expected_categories)
    end

    context 'when categories are not available on the HTML' do
      let(:html) { empty_html }

      it 'returns an empty string' do
        expect(subject.categories).to be_an(Array)
        expect(subject.categories).to  be_empty
      end
    end
  end
end
