class ProductImporter
  def self.import(params)
    code = Digest::MD5.hexdigest(params[:url])
    Product.where(code: code).first_or_create(params.slice(:url, :name, :price)).tap do |product|
      params[:reviews].each do |review_params|
        review_code = Digest::MD5.hexdigest("#{review_params[:title]} - #{review_params[:user]} - #{review_params[:location]}")
        product.reviews.where(code: review_code).first_or_create(review_params.slice(:title, :content, :user, :location))
      end
    end
  end
end
