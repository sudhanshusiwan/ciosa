class Product < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'

  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many :orders

  scope :approved, -> { where( approval_status: true  )}

  validates :name, :price, :description, :creator_id, presence: true
end
