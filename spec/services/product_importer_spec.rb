require 'rails_helper'

RSpec.describe ProductImporter do
  describe ".import" do
    let(:product_params) { attributes_for(:product).except(:code) }
    let(:review_params) { attributes_for(:review).except(:code) }

    context "when the product has not been imported before" do
      let(:params) { product_params.merge(reviews: [review_params]) }

      it "creates the product" do
        expect {
          ProductImporter.import(params)
        }.to change { Product.count }.by(1)
      end

      it "creates the product with the correct code" do
        product = ProductImporter.import(params)
        code = Digest::MD5.hexdigest(params[:url])

        expect(product.code). to eq(code)
      end

      it "creates all the related reviews" do
        expect {
          ProductImporter.import(params)
        }.to change { Review.count }.by(1)
      end
    end

    context "when the product has been already imported" do
      let(:new_review_params) { attributes_for(:review, title: "Bad", content: "Really bad.", user: "Hater", location: "Hell").except(:code) }
      let(:params) { product_params.merge(reviews: [review_params, new_review_params]) }

      let!(:product) { create(:product, product_params)}
      before { create(:review, review_params.merge(product: product))}

      it "does not create a duplicated product" do
        expect {
          ProductImporter.import(params)
        }.not_to change { Product.count }
      end

      it "does not create duplicated reviews" do
        expect {
          ProductImporter.import(params)
        }.to change { Review.count }.by(1)
      end
    end
  end
end
