class Product < ActiveRecord::Base
  include Approval

  belongs_to :creator, class_name: 'User'

  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many :orders

  validates :name, :price, :description, :creator_id, presence: true

  scope :all_products, -> { all }
  
  has_attached_file :image, {styles: {thumb: '250x250>', medium: '400x400>'},
                             :url  => "/assets/images/users/:id/:style/:basename.:extension",
                             :path => ":rails_root/public/assets/images/users/:id/:style/:basename.:extension",
                             :default_url => "users/default/:style/missing.png"}

  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png image/gif)
end
