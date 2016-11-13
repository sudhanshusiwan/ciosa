class OrderedProductsController < ApplicationController

  def index
    order_id = params[:id]

    order = Order.where( id: order_id ).first
    @ordered_products = order.ordered_products
  end
end