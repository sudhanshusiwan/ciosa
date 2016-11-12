ActiveAdmin.register Organization do


	scope 'All', :all_organizations
  scope 'Approved Organizations', :approved_organizations
  scope 'Un Approved Organizations', :unapproved_organizations


  index do
    id_column
    column :name
    column :email
    column 'Creator' do |object|
    	object.creator.name
    end
   	column :is_approved

    actions
  end

  action_item( :approve, only: :show ) do
    if resource.un_approved? || resource.declined?
      link_to 'Approve', approve_admin_organization_path
    end
  end

  action_item( :decline, only: :show ) do
    if resource.un_approved? || resource.approved?
      link_to 'Decline', decline_admin_organization_path
    end
  end

  member_action :approve, method: :get do
    @organization = Organization.find(params[:id])
    @organization.approve!

    flash[:success] = "Organization has been approved successfully!"
    redirect_to admin_organization_path( id: @organization.id ) and return
  end

  member_action :decline, method: :get do
    @organization = Organization.find(params[:id])
    @organization.decline!

    flash[:success] = "Organization has been declined successfully!"
    redirect_to admin_organization_path( id: @organization.id ) and return
  end
end