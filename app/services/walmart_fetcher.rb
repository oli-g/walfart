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

    # TODO: should I build it instead of searching it in HTML?
    reviews_url = "https://www.walmart.com" + doc.at_css("a.js-reviews-see-all")["href"]
    reviews = []
    reviews.concat(fetch_reviews(reviews_url))

    { product: { url: @url, name: name, price: price, reviews: reviews } }
  end

  private

  def fetch_reviews(reviews_url)
    doc = Nokogiri::HTML(open(reviews_url))
    doc.css("div.js-review-list div.customer-review").map do |item|
      title = item.at_css("div.customer-review-title").content.strip
      content = item.at_css("div.customer-review-text p").content.strip
      user = item.css("div.customer-info div").first.content
      location = item.at_css("div.customer-info div.customer-location").content

      { title: title, content: content, user: user, location: location }
    end
  end
end
