class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :cancel]

  def index
    @orders = current_user.orders.order('id desc').includes(ordered_products: :product)
  end

  def check_out
    @cart_products = current_user.cart_products.order('id desc').includes(:product)
  end

  def create
    cart_product_ids = params[:cart_product_ids].split
    address_params = { billing_address: params[:billing_address], delivery_address: params[:delivery_address] }

    order_id = Order.create_order_and_ordered_products(cart_product_ids, address_params, current_user)

    if order_id.nil?
      flash[:success] = 'Something went wrong, Please try again later'
      redirect_to check_out_orders_path
    else
      flash[:success] = 'Order has been placed successfully'
      redirect_to order_path(id: order_id)
    end
  rescue Exception => ex
    flash[:error] = ex.message

    redirect_to check_out_orders_path
  end

  def show

  end

  def cancel
    @order.update_attributes!(cancelled: true)

    redirect_to orders_path
  rescue => ex
    flash[:error] = ex.message

    redirect_to orders_path
  end

  private
  def set_order
    @order = Order.where(id: params[:id]).first
  end

  def order_params
    order_params = params.require(:order).permit(:total_price)
    order_params.merge!(creator_id: current_user.id, ordered_product_ids: params[:product_ids])
  end
end
