require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many(:children).dependent(:destroy) }
  it { is_expected.to have_many(:products).dependent(:nullify) }
  it { is_expected.to belong_to(:parent) }

  it { is_expected.to validate_presence_of(:name) }
end
