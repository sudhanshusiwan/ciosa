class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :cart_product_count

  def cart_product_count
    if current_user.present?
      current_user.cart_products.size
    else
      0
    end
  end
end
