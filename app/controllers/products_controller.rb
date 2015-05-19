class ProductsController < ApplicationController

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
    @product = Product.find(params[:id])
  end

  # POST /products
  def create
    attributes = WalmartFetcher.fetch(product_params[:url])
    @product = ProductImporter.import(attributes[:product]) if attributes

    if attributes && @product.valid?
      redirect_to @product, notice: 'Product was successfully imported.'
    else
      @products = Product.all
      flash.now[:alert] = 'Product was not imported.'
      render :index
    end
  end

  # DELETE /products/1
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product).permit(:url)
  end
end
