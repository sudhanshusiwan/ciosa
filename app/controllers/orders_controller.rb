class OrdersController < ApplicationController
  before_action :set_product, only: [:create, :edit, :update]

  def index
    @orders = current_user.orders
  end

  def create
    cart_product_ids = params[:cart_product_ids]
    order_params = params[:order_params]

    Order.create_order_and_ordered_products(cart_product_ids, order_params, current_user)

    redirect_to( products_path, success: 'Order has been placed successfully') and return
  rescue Exception => ex
    puts ex.message
    puts ex.backtrace
    flash[:error] = ex.message

    redirect_to( products_path, success: 'Error occured while placing order')
  end

  def show

  end

  def destroy
    @order.destroy!
    redirect_to( products_path, success: 'Order has been cancelled successfully') and return

  rescue => ex
    redirect_to( products_path, error: 'Error while cancelling the order, please try again after some' )
  end


  private
  def set_product
    @product = Product.where( id: params[:id] ).includes(:categories).first
  end

  def order_params
    order_params = params.require(:order).permit(:total_price)
    order_params.merge!(creator_id: current_user.id, ordered_product_ids: params[:product_ids])
  end
end
