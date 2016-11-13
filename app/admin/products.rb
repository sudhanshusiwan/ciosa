ActiveAdmin.register Product do
  permit_params :name, :description, :price, :available_quantity, :image, categories: []

	scope 'All', :all_products
  scope 'Approved Product', :approved
  scope 'Un Approved Product', :unapproved


  index do
    id_column
    column :name
    column :description
    column :price
    column :is_approved
    column 'Creator' do |object|
    	object.creator.name
    end
   	column :image

    actions
  end

  form :partial => 'form'

  action_item( :approve, only: :show ) do
    if resource.declined? || resource.is_approved.nil?
      link_to 'Approve', approve_admin_product_path
    end
  end

  action_item( :decline, only: :show ) do
    if resource.approved? || resource.is_approved.nil?
      link_to 'Decline', decline_admin_product_path
    end
  end

  member_action :approve, method: :get do
    @product = Product.find(params[:id])
    @product.approve!

    flash[:success] = "Product has been approved successfully!"
    redirect_to admin_product_path( id: @product.id ) and return
  end

  member_action :decline, method: :get do
    @product = Product.find(params[:id])
    @product.decline!

    flash[:success] = "Product has been declined successfully!"
    redirect_to admin_product_path( id: @product.id ) and return
  end
end