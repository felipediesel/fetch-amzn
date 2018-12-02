require 'open-uri'

class FetchPageService
  AMAZON_HOST = 'https://www.amazon.com/dp'

  attr_reader :asin

  def initialize(asin)
    @asin = asin
  end

  def html
    url = '#{AMAZON_HOST}/#{asin}'

    URI.parse(url).read
  end
end
