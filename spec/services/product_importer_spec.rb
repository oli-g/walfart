require 'rails_helper'

RSpec.describe ProductImporter do
  describe ".import" do
    context "when the product has not been imported before" do
      let(:params) { attributes_for(:product) }

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
    end

    context "when the product has been already imported" do
      let(:params) { attributes_for(:product) }
      before { create(:product, params)}

      it "does not create a duplicated product" do
        expect {
          ProductImporter.import(params)
        }.not_to change { Product.count }
      end
    end
  end
end
