class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  validates :url, presence: true
  validates :code, presence: true, uniqueness: true
end
