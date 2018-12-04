require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let!(:product) { Product.create asin: asin, category: category }
  let!(:product2) { Product.create asin: 'B01DFKC2SO' }

  let!(:category) { Category.create(name: 'Baby') }
  let!(:rank) { Rank.create(position: 10, product: product, category: category) }

  let(:product_id) { product.id }
  let(:asin) { 'B002QYW8LW' }
  let(:json) { JSON.parse(response.body) }

  describe 'GET /products' do
    let(:params) { {} }
    before { get '/products', params: params }

    it 'returns products' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'includes ranks' do
      expect(json[0]['id']).to eq(product_id)
      expect(json[0]['ranks'].size).to eq(1)
      expect(json[0]['ranks'][0]['id']).to eq(rank.id)
    end

    it 'includes ranks categories' do
      categories = json[0]['ranks'][0]['categories']

      expect(json[0]['id']).to eq(product_id)
      expect(categories.size).to eq(1)
      expect(categories[0]['id']).to eq(category.id)
    end

    it 'includes categories' do
      expect(json[0]['id']).to eq(product_id)
      expect(json[0]['categories'].size).to eq(1)
      expect(json[0]['categories'][0]['id']).to eq(category.id)
    end

    context 'when asin param is provided' do
      let(:params) { { asin: asin } }

      it 'returns products with the provided asin' do
        expect(json[0]['id']).to eq(product_id)
        expect(json.size).to eq(1)
      end
    end
  end

  describe 'GET /products/:id' do
    before { get "/products/#{product_id}" }

    context 'when the record exists' do
      it 'returns the product' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(product_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:product_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  describe 'POST /products' do
    let(:valid_attributes) { { asin: 'B07CXG6C9W' } }

    context 'when the request is valid' do
      before { allow(LoadProductDataJob).to receive(:perform_later) }
      before { post '/products', params: valid_attributes }

      it 'creates a product' do
        expect(json['asin']).to eq('B07CXG6C9W')
      end

      it 'enquees a job to fetch product data' do
        expect(LoadProductDataJob).to have_received(:perform_later).with(an_instance_of(Product))
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/products', params: { asin: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Asin can't be blank/)
      end
    end
  end

  describe 'DELETE /products/:id' do
    before { delete "/products/#{product_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
