require 'spec_helper'
require_relative '../../app/services/walmart_fetcher'
require_relative '../support/vcr'

RSpec.describe WalmartFetcher, :vcr do
  describe ".fetch" do
    let(:product_url) { "http://www.walmart.com/ip/Ematic-9-Dual-Screen-Portable-DVD-Player-with-Dual-DVD-Players-ED929D/28806789" }
    let(:product_name) { %Q{Ematic 9" Dual Screen Portable DVD Player with Dual DVD Players (ED929D)} }
    let(:product_price) { "$108.00" }
    let(:review_title) { "Great product so far!" }
    let(:review_content) { "We went on a trip to Missouri so we bought this for our 4 year old daughter and 8 month son. We originally bought the RCA DVD player but we returned never even used it b/c it felt so cheap. This DVD player (ematic) felt a lot heavier duty than the RCA. The only issue we had was when we set it up I had the straps too tight and it would say no DVD even though there was one in there but I loosened the straps and it has worked like a charm. We played them the whole way there and home and its an 17 hour ride one way. The kids loved them and it kept them entertained. You can use a usb flashdrive to download movies but check it before you go on a trip some of the movies we downloaded didn't play. You can also use an sd card but we didn't so can't tell you anything about that. The nice thing was we could play 2 different movies at the same time which will come in handy when the kids are older. Overall we are very satisfied with this product." }
    let(:review_user) { "MamaG85" }
    let(:review_location) { "Chiefland, FL" }

    it "returns the name and the price of the product" do
      product = WalmartFetcher.fetch(product_url)[:product]

      expect(product[:name]).to eq(product_name)
      expect(product[:price]).to eq(product_price)
      expect(product[:url]).to eq(product_url)
    end

    it "returns all the reviews of the product" do
      product = WalmartFetcher.fetch(product_url)[:product]

      expect(product[:reviews]).to have(20).reviews
    end

    it "returns the title and the content of reviews" do
      product = WalmartFetcher.fetch(product_url)[:product]
      review = product[:reviews].first

      expect(review[:title]).to eq(review_title)
      expect(review[:content]).to eq(review_content)
      expect(review[:user]).to eq(review_user)
      expect(review[:location]).to eq(review_location)
    end
  end
end
