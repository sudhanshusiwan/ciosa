class CartProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :quantity, presence: true

  def update_product_quantity( quantity )
    response_hash = { status: true, message: 'Product has been updated successfully' }
    product = self.product

    requested_quantity = self.quantity + quantity

    if requested_quantity > product.available_quantity
      return { status: false, message: 'Product ran out of stock', quantity: self.quantity }
    elsif quantity <= 0
      return { status: false, message: 'Quantity cannot be lesser than or equal to Zero', quantity: self.quantity }
    end

    available_quantity = ( product.available_quantity - quantity )
    CartProduct.transaction do
      product.update_attributes!( available_quantity: available_quantity )
      self.update_attributes!(quantity: requested_quantity)
    end

    response_hash.merge!(quantity: self.quantity)
  end
end
