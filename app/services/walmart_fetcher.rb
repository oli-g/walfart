require "open-uri"
require "nokogiri"

class WalmartFetcher
  def self.fetch(url)
    new(url).fetch
  end

  def initialize(url)
    @url = url
  end

  def fetch
    doc = Nokogiri::HTML(open(@url))
    name = doc.at_css("h1.product-name").content.strip
    price = doc.at_css("div.product-price div.price").content.strip

    { product: {url: @url, name: name, price: price} }
  end

  private
end
