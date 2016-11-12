class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :cart_product_count
  before_action :authenticate_admin_users

  def cart_product_count
    if current_user.present?
      current_user.cart_products.size
    else
      0
    end
  end

  def authenticate_admin_users
  	return unless is_activeadmin?

  	authenticate_user!

  	unless User::USER_TYPE_ADMIN == current_user.user_type
  		flash[:notice] = 'You are not an admin user, you can not access admin dashboard!'
  		sign_out( current_user ) and return false
  	end
  end

  ## Check whether the url contains admin, if so skip before filters.
  def is_activeadmin?
    controller_path.match(/admin/) || 'admin' == params[:path]
  end
end
