require 'open-uri'

class FetchPageService
  AMAZON_URL = 'https://www.amazon.com/dp'

  attr_reader :asin

  def initialize(asin)
    @asin = asin
  end

  def html
    url = "#{AMAZON_URL}/#{asin}"

    URI.parse(url).read

    # Sometimes fetching with the above method returns 503.
    # The code below works, but it's not secure and it's harder to test
    # `wget -O - -o /dev/null #{url}`
  end
end
