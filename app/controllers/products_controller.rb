class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.all #.approved.includes(:categories)
  end

  def new
    @product = Product.new
  end

  def search
    if params[:q].blank?
      redirect_to products_path and return
    end

    products = Product.where('LOWER(name) like ?', "%#{params[:q]}%")
    products += Category.where('LOWER(name) like ?', "%#{params[:q]}%").includes(:products).flat_map(&:products)

    @products = products.uniq

    render :index
  end

  def create
    @product = Product.create!(product_params)

    redirect_to product_path(id: @product.id)
  rescue Exception => ex
    flash[:error] = ex.message
    @product = Product.new(product_params)

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
    @product = Product.new(product_params)

    render :new
  end

  def destroy
    @product.destroy!

    redirect_to products_path
  end

  private

  def set_product
    @product = Product.where( id: params[:id] ).includes(:categories).first
  end

  def product_params
    product_params = params.require(:product).permit(:name, :description, :price, :available_quantity, :image, categories: [])
    product_params.merge!(creator_id: current_user.id)
  end
end
