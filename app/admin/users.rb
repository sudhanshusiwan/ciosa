ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation, :current_password, 
                :mobile, :address, :organization_id, :pan_number, :bank_name, :account_number

	scope 'All', :all_users
  scope 'Approved User', :approved
  scope 'Un Approved User', :unapproved


  index do
    id_column
    column :name
    column :email
    column 'Organization' do |object|
    	object.is_buyer? ? '' : ( object.organization.name rescue '' )
    end
   	column :is_approved

    actions
  end

  form :partial => 'form'

  action_item( :approve, only: :show ) do
    if resource.declined? || ( resource.is_seller? && resource.is_approved.nil? )
      link_to 'Approve', approve_admin_user_path
    end
  end

  action_item( :decline, only: :show ) do
    if resource.approved? || ( resource.is_seller? && resource.is_approved.nil? )
      link_to 'Decline', decline_admin_user_path
    end
  end

  member_action :approve, method: :get do
    @user = User.find(params[:id])
    @user.approve!

    flash[:success] = "User has been approved successfully!"
    redirect_to admin_user_path( id: @user.id ) and return
  end

  member_action :decline, method: :get do
    @user = User.find(params[:id])
    @user.decline!

    flash[:success] = "User has been declined successfully!"
    redirect_to admin_user_path( id: @user.id ) and return
  end
end