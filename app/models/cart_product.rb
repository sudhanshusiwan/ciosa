class CartProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :quantity, presence: true

  def update_product_quantity( requested_quantity )
    response_hash = { status: true, message: 'Product has been updated successfully' }
    product = self.product

    if requested_quantity > product.available_quantity
      return { status: false, message: 'Product ran out of stock', quantity: self.quantity }
    elsif requested_quantity <= 0
      return { status: false, message: 'Quantity cannot be lesser than or equal to Zero', quantity: self.quantity }
    elsif requested_quantity < self.quantity
      released_quantity = self.quantity - requested_quantity
      CartProduct.transaction do
        product.update_attributes!(available_quantity: product.available_quantity + released_quantity)
        self.update_attributes!(quantity: requested_quantity)
      end
    elsif requested_quantity == self.quantity
      binding
      return response_hash.merge!(quantity: self.quantity, total_price: self.quantity * product.price)
    else
      extra_quantity = ( requested_quantity - self.quantity )
      CartProduct.transaction do
        product.update_attributes!( available_quantity: product.available_quantity - extra_quantity )
        self.update_attributes!(quantity: requested_quantity)
      end
    end

    response_hash.merge!(quantity: self.quantity, total_price: self.quantity * product.price)
  end
end
