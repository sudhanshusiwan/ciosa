class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :user, :product, :price, presence: true
end
