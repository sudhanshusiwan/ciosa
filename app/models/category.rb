class Category < ActiveRecord::Base
  has_many :orders

  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, presence: true, uniqueness: true

  def self.find_products(name_string)
  	catagories = Category.where('LOWER(name) like ?', "%#{name_string.downcase}%").includes(:products)

  	catagories.flat_map do |category|
  		category.products.select { |product| product.approved? }
  	end
  end
end
