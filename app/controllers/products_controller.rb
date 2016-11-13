class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, :access_to_seller_user, only: [:new, :create, :edit, :update, :destroy, :manage_my_products]

  def index
    @products = Product.order('id desc').approved.includes(:categories)
  end

  def new
    @product = Product.new
  end

  def search
    if params[:q].blank?
      redirect_to products_path and return
    end

    products = Product.approved.where('LOWER(name) like ?', "%#{params[:q].downcase}%")
    products += Category.where('LOWER(name) like ?', "%#{params[:q].downcase}%").includes(:products).flat_map(:products)

    @products = products.uniq

    render :index
  end

  def create
    @product = Product.create!(product_params)
    NotificationMailers.send_new_product_registration_notification( @product.id ).deliver_now

    redirect_to product_path(id: @product.id)
  rescue Exception => ex
    flash[:error] = ex.message
    @product = Product.new(product_params)

    render :new
  end

  def show
    @product = Product.find( params[:id] )
  rescue
    redirect_to products_path
  end

  def edit
    render :new
  end

  def update
    @product.update_attributes!(product_params.except(:creator_id))

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

  def manage_my_products
    @products = Product.where(creator_id: current_user.id)
  end

  private

  def set_product
    @product = Product.where( id: params[:id] ).includes(:categories).first
  end

  def product_params
    product_params = params.require(:product).permit(:name, :description, :price, :available_quantity, :image, category_ids: [])
    product_params.merge!(creator_id: current_user.id)
  end

  def access_to_seller_user
    unless current_user.is_seller? && current_user.approved?
      flash[:alert] = 'You are not authorized to access this page!'
      redirect_to products_path and return false
    end
  end
end
