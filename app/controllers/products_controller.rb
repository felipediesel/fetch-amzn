class ProductsController < ApplicationController
  before_action :set_product, only: %i(show destroy)

  def index
    @products = Product.includes(:category, ranks: :category)
    @products = @products.where(asin: params[:asin]) if params[:asin]

    render json: @products, methods: :categories, include: { ranks: { methods: :categories } }
  end

  def create
    @product = Product.create!(product_params)
    LoadProductDataJob.perform_later(@product)
    render json: @product, status: :created
  end

  def show
    render json: @product, include: %i(ranks category)
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private
    def product_params
      params.permit(:asin)
    end

    def set_product
      @product = Product.find(params[:id])
    end
end
