require 'rails_helper'

RSpec.describe LoadProductDataJob, type: :job do
  let(:product) { Product.create!(asin: 'B002QYW8LW') }
  let(:service_double) { double('FetchProductDataService', call: nil) }

  before do
    allow(FetchProductDataService).to receive(:new).and_return(service_double)
  end

  it 'calls FetchProductDataService' do
    LoadProductDataJob.perform_now(product)
    expect(FetchProductDataService).to have_received(:new)
    expect(service_double).to have_received(:call)
  end
end
