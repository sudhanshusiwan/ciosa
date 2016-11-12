class CartProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :quantity, presence: true
end
