class CartProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :quantity, presence: true

  def update_product_quantity( quantity )
    response_hash = { status: true, message: 'Product has been updated successfully' }
    product = self.product

    requested_quantity = cart_product.quantity + quantity

    if requested_quantity > product.available_quantity
      response_hash = { status: false, message: 'Product ran out of stock' }
      return response_hash
    elsif quantity <= 0
      self.destroy!

      response_hash = { status: false, message: 'Product got deleted from cart' }
      return response_hash
    end

    available_quantity = ( product.available_quantity - quantity )
    product.update( available_quantity: available_quantity )

    response_hash
  end
end
