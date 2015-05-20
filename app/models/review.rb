class Review < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :code, presence: true, uniqueness: true

  belongs_to :product
end
