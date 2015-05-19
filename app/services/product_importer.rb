class ProductImporter
  def self.import(params)
    code = Digest::MD5.hexdigest(params[:url])
    Product.where(code: code).first_or_create(params.slice(:url, :name, :price))
  end
end
