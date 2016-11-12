class OrderedProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :price, :quantity, presence: true
end