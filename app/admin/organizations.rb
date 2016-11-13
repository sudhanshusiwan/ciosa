ActiveAdmin.register Organization do
  permit_params :name, :creator, :email, :mobile, :address, :organization_type, :products_sold,
                :pan_tin_number, :is_store, :is_eco_friendly, :can_do_logistics


	scope 'All', :all_organizations
  scope 'Approved Organizations', :approved
  scope 'Un Approved Organizations', :unapproved


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
    if resource.is_approved.nil? || resource.declined?
      link_to 'Approve', approve_admin_organization_path
    end
  end

  action_item( :decline, only: :show ) do
    if resource.is_approved.nil? || resource.approved?
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