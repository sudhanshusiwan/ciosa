class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update]

  def index
    @products = Product.approved.includes(:categories)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create!(product_params)

    redirect_to product_path(id: @product.id)
  rescue Exception => ex
    flash[:error] = ex.message
    @product = Product.build(product_params)

    render :new
  end

  def show

  end

  def edit
    render :new
  end

  def update
    @product.update_attributes!(product_params)

    redirect_to product_path(id: @product.id)
  rescue Exception => ex
    flash[:error] = ex.message
    @product = Product.build(product_params)

    render :new
  end

  def destroy
    @product.destroy!

    redirect_to products_path
  end


  private
  def set_product
    @product = Product.where( id: params[:id] ).first
  end

  def product_params
    product_params = params.require(:product).require(:name, :description, :price, :approval_status)
    product_params.merge!(creator_id: 1)
  end
end
