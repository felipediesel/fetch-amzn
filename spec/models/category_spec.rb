require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many(:children).dependent(:destroy) }
  it { is_expected.to have_many(:products).dependent(:nullify) }
  it { is_expected.to belong_to(:parent) }

  it { is_expected.to validate_presence_of(:name) }

  describe '#create_from_list' do
    let(:names) { ['Baby Products', 'Baby Care', 'Pacifiers, Teethers & Teething Relief', 'Teethers'] }

    it 'create categories based on the provided list' do
      expect{ Category.create_from_list(names) }.to change(Category, :count).by(4)
    end

    it 'returns the created categories' do
      expect(Category.create_from_list(names).map(&:name)).to eq names
    end

    it 'sets each category parent as the previous item on the array' do
      categories = Category.create_from_list(names)

      expect(categories[0].parent).to be_nil
      expect(categories[1].parent).to eq categories[0]
      expect(categories[2].parent).to eq categories[1]
      expect(categories[3].parent).to eq categories[2]
    end

    context 'when a category is null' do
      it 'does not create categories' do
        expect{ Category.create_from_list([]) }.not_to change(Category, :count)
      end
    end

    context 'when a category already exists' do
      context 'when a category with the same name and parent exists' do
        before do
          parent = Category.create! name: names[0]
          Category.create! name: names[1], parent: parent
        end

        it 'does not create a new category' do
          expect{ Category.create_from_list(names) }.to change(Category, :count).by(2)
        end
      end

      context 'when parent is different' do
        let(:names) { ['Baby Products', 'Baby Care', 'Pacifiers, Teethers & Teething Relief', 'Teethers']}

        before do
          Category.create! name: names[1]
        end

        it 'create a new category ' do
          expect{ Category.create_from_list(names) }.to change(Category, :count).by(4)
        end
      end
    end
  end
end
