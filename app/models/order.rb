class Order < ActiveRecord::Base
  belongs_to :user
  has_many :ordered_products

  validates :billing_address, :delivery_address, :total_price, presence: true

  def self.create_order_and_ordered_products( cart_product_ids, order_params, order_user )
    cart_products = CartProduct.where( id: cart_product_ids ).includes(:product)
    products = cart_products.map(&:product)

    # Create order with total price, billing and delivery address.
    order_attributes = { total_price: products.map(&:price).sum, billing_address: order_params[:billing_address],
                     delivery_address: order_params[:delivery_address], user_id: order_user.id }

    order = Order.create!( order_attributes )

    # Create order product objects. This is to maintain history of products and its price in each order.
    cart_products.each do |cart_product|
      order_product_attributes = { order_id: order.id, product_id: cart_product.product_id,
                             price: cart_product.product.price, quantity: cart_product.quantity }
      OrderedProduct.create!( order_product_attributes )
    end

    cart_products.destroy_all
  end
end
