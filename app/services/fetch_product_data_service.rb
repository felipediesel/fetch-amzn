class FetchProductDataService
  attr_reader :product

  def initialize(product)
    @product = product
  end

  def call
    product.dimensions = data.dimensions
    product.category = Category.create_from_list(data.categories).last
    product.save!

    data.ranking.each do |rank|
      category = Category.create_from_list(rank[:categories]).last
      Rank.create!(position: rank[:position], product: product, category: category)
    end
  end

  private
    def data
      @data ||= ParsePageService.new(html)
    end

    def html
      @html ||= FetchPageService.new(product.asin).html
    end
end
