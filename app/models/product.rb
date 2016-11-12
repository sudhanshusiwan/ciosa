class Product < ActiveRecord::Base

  has_many :product_categories
  has_many :categories, through: :product_categories

  scope :approved, -> { where( approval_status: true  )}

  validates :name, :price, :description, :creator_id, presence: true


end