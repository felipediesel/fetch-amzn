require 'rails_helper'

RSpec.describe FetchPageService, type: :model do
  subject { described_class.new('B002QYW8LW') }

  describe '#html' do
    let(:content) { 'content' }

    before do
      allow(URI).to receive(:parse).and_return(double('URI', read: content))
    end

    it 'fetches the amazon page' do
      expect(URI).to receive(:parse).with('https://www.amazon.com/dp/B002QYW8LW')
      subject.html
    end

    it 'returns the fetched page' do
      expect(subject.html).to eq(content)
    end
  end
end
