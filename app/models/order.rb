class Order < ActiveRecord::Base
  belongs_to :user
  has_many :ordered_products

  validates :user, :product, :price, presence: true

  def self.create_order_and_ordered_products( cart_product_quantity_hash, order_params, order_user )
    cart_products = CartProduct.where( product_id: cart_product_quantity_hash.keys )
    products = cart_products.map(&:product)

    # Create order with total price, billing and delivery address.
    order_attributes = { total_price: products.map(&:price).sum, billing_address: order_params[:billing_address],
                     delivery_address: order_params[:delivery_address] }
    order = Order.create!( order_attributes )

    # Create order product objects. This is to maintain history of products and its price in each order.
    products.each do |product|
      order_product_attributes = { order_id: order.id, product_id: product.id, user_id: order_user.id,
                             price: product.price, quantity: cart_product_quantity_hash[:quantity] }
      OrderedProduct.create!( order_product_attributes )
    end

    cart_products.destroy_all
  end
end
