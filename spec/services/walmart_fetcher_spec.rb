require 'spec_helper'
require_relative '../../app/services/walmart_fetcher'

RSpec.describe WalmartFetcher do
  describe ".fetch" do
    let(:product_url) { "http://www.walmart.com/ip/Ematic-9-Dual-Screen-Portable-DVD-Player-with-Dual-DVD-Players-ED929D/28806789" }
    let(:product_name) { %Q{Ematic 9" Dual Screen Portable DVD Player with Dual DVD Players (ED929D)} }
    let(:product_price) { "$108.00" }

    it "returns the name and the price of the product" do
      product = WalmartFetcher.fetch(product_url)[:product]

      expect(product[:name]).to eq(product_name)
      expect(product[:price]).to eq(product_price)
      expect(product[:url]).to eq(product_url)
    end

    it "returns all the reviews of the product" do
    end
  end
end
