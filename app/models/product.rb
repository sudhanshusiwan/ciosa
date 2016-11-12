class Product < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'

  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many :orders

  scope :approved, -> { where( approval_status: true  )}

  validates :name, :price, :description, :creator_id, presence: true


  has_attached_file :image, styles: {thumb: '250x250>', medium: '400x400>'}
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png image/gif)
end
