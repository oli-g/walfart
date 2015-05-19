require 'rails_helper'

RSpec.describe "Products", :vcr, type: :request do
  describe "GET /products" do
    it "renders the products list page" do
      get products_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /products" do
    let(:url) { "http://www.walmart.com/ip/Ematic-9-Dual-Screen-Portable-DVD-Player-with-Dual-DVD-Players-ED929D/28806789" }
    let(:name) { %Q{Ematic 9" Dual Screen Portable DVD Player with Dual DVD Players (ED929D)} }
    let(:price) { "$108.00" }

    context "when the product has not been imported before" do
      let(:product) { Product.where(url: url).first }

      it "redirects to the product detail page" do
        expect(
          post products_path, product: { url: url }
        ).to redirect_to(product_path(product))
      end

      it "creates the product" do
        expect {
          post products_path, product: { url: url }
        }.to change { Product.count }.by(1)
      end
    end

    context "when the product has been already imported" do
      let!(:product) { create(:product, url: url, name: name, price: price) }

      it "redirects to the product detail page" do
        expect(
          post products_path, product: { url: url }
        ).to redirect_to(product_path(product))
      end

      it "does not create a duplicated product" do
        expect {
          post products_path, product: { url: url }
        }.not_to change { Product.count }
      end
    end
  end
end
