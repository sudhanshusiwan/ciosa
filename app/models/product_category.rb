class ProductCategory < ActiveRecord::Base
  belongs_to :product
  belongs_to :category

  validates_uniqueness_of :product, scope: [:category]
end