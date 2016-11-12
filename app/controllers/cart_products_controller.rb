class CartProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:create]
  before_action :set_cart_product, only: [:update, :destroy, :show]

  def index
    @cart_products = current_user.cart_products.includes(:product)
  end

  def create
    @cart_product = CartProduct.create!(product_id: @product.id, user_id: current_user.id, quantity: 1)

    render json: { status: false, message: "Product successfully added to cart"  }

  rescue => ex
    render json: { status: false, message: "Error while creating cart #{ex.message}"  }
  end

  # todo change this ajax call
  def update
    response_hash =  @cart_product.update_product_quantity( params[:quantity] )
    render json: response_hash

  rescue => ex
    render json: { status: false, message: "Error while updating cart #{ex.message}" }
  end

  # todo change this to ajax call
  def destroy
    @cart_product.destroy!

    redirect_to products_path
  rescue => ex
    flash[:error] = ex.message
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.where(id: params[:pid]).first
  end

  def set_cart_product
    @cart_product = CartProduct.where( id: params[:id] ).first
  end
end