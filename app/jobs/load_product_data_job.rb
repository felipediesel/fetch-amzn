class LoadProductDataJob < ApplicationJob
  queue_as :default

  def perform(product)
    FetchProductDataService.new(product).call
  end
end
