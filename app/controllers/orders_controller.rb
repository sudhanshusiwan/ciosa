class OrdersController < ApplicationController
  before_action :set_product, only: [:create, :edit, :update]

  def index
    @orders = current_user.orders.includes(ordered_products: :product)
  end

  def create
    cart_product_ids = params[:cart_product_ids]
    order_params = params[:order_params]

    order_id = Order.create_order_and_ordered_products(cart_product_ids, order_params, current_user)

    if order_id.nil?
      flash[:notice] = 'Something went wrong, Please try again later'
      redirect_to orders_path
    else
      flash[:notice] = 'Order has been placed successfully'
      redirect_to order_path(id: order_id)
    end
  rescue Exception => ex
    flash[:error] = ex.message

    redirect_to orders_path
  end

  def show
    @order = Order.where(id: params[:id]).first
  end

  def destroy
    @order.update_attributes!(cancelled: true)

    redirect_to orders_path
  rescue => ex
    flash[:error] = ex.message

    redirect_to orders_path
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
