class CartProductsController < ApplicationController
  before_action :set_cart_product, only: [ :update, :destroy, :show ]

  def index
    @cart_product = current_user.cart_products
  end

  def create
    @cart_product = CartProduct.create!( cart_product_params )

    render json: { status: true, message: 'Successfully added product to cart' } and return

  rescue => ex
    render json: { status: false, message: "#{ex.message}" }
  end

  def update
    @cart_product.update_attributes!(cart_product_params)

    redirect_to products_path
  rescue Exception => ex
    flash[:error] = ex.message
    @cart_product = CartProduct.new(cart_product_params)

    render :new
  end

  def destroy
    @cart_product.destroy!

    redirect_to products_path
  rescue => ex
    flash[:error] = ex.message
    redirect_to products_path
  end

  private

  def set_cart_product
    @cart_product = CartProduct.where( id: params[:id] ).first
  end

  def cart_product_params
    cart_product_params = params.require(:cart_product).permit(:product_id, :quantity)
    cart_product_params.merge( user_id: current_user.id )
  end

end