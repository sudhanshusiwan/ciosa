class CartProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:create]
  before_action :set_cart_product, only: [:update, :destroy, :show]

  def index
    @cart_products = current_user.cart_products.includes(:product)
  end

  def create
    cart_product = current_user.cart_products.detect{|cart_product| cart_product.product_id == @product.id}
    if cart_product.present?
      response_hash =  @cart_product.update_product_quantity( params[:quantity] )
      if response_hash[:status]
        flash[:success] = 'Product already added to card and the quantity is updated'
      else
        response_hash[:message]
      end
    else
      @cart_product = CartProduct.create!(product_id: @product.id, user_id: current_user.id, quantity: 1)
    end

    flash[:success] = 'Product successfully added to cart'

    if params[:q].present?
      redirect_to products_path(q: params[:q])
    else
      redirect_to products_path
    end

  rescue => ex
    flash[:success] = "Error while creating cart #{ex.message}"

    if params[:q].present?
      redirect_to products_path(q: params[:q])
    else
      redirect_to products_path
    end
  end

  def update
    response_hash =  @cart_product.update_product_quantity( params[:quantity] )

    render json: response_hash
  rescue => ex
    render json: { status: false, message: "Error while updating cart #{ex.message}" }
  end

  def destroy
    @cart_product.destroy!

    redirect_to cart_products_path
  rescue => ex
    flash[:error] = ex.message

    redirect_to cart_products_path
  end

  private

  def set_product
    @product = Product.where(id: params[:pid]).first
  end

  def set_cart_product
    @cart_product = CartProduct.where( id: params[:id] ).first
  end
end
