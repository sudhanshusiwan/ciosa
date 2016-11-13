class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, :access_to_seller_user, only: [:new, :create, :edit, :update, :destroy, :manage_my_products]

  def home
    @products = Product.order('id desc').approved.includes(:categories)
  end

  def index
    @products = Product.order('id desc').approved.includes(:categories)
  end

  def new
    @product = Product.new
  end

  def search
    products = []

    if params[:q].blank? && params[:category].blank?
      redirect_to products_path and return
    end

    if params[:q].present?
      products += Product.approved.where('LOWER(name) like ?', "%#{params[:q].downcase}%")
      products += Category.find_products(params[:q]) if params[:category].blank?
    end

    if params[:category].present?
      products += Category.find_products(params[:category])
    end

    @products = products.uniq

    render :index
  end

  def create
    @product = Product.create!(product_params)
    NotificationMailers.send_new_product_registration_notification( @product.id ).deliver_now

    redirect_to product_path(id: @product.id)
  rescue Exception => ex
    puts ex
    puts ex.backtrace

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
    product_attributes = product_params.merge( old_attributes: @product.slice('name', 'description', 'price', 'available_quantity', 'is_eco_friendly' ) )
    product_attributes = product_attributes.merge( is_approved: false ).except(:creator_id)
    @product.update_attributes!(product_attributes)

    flash[:success] = 'Product will appear in index page, once its approved by admin'
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
      flash[:alert] = 'You are  not authorized to access this page!'
      redirect_to products_path and return false
    end
  end
end
