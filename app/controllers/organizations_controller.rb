class OrganizationsController < ApplicationController
	before_action :authenticate_user!

	def new
		@organization = Organization.new
	end

	def create
		@organization = Organization.new( organization_params )
		@organization.creator_id = current_user.id
		@organization.save!

		NotificationMailers.send_new_organization_registration_notification( @organization.id ).deliver_now

		flash[:success] = 'Yay!! Organization created successfully!!'
		redirect_to organization_path(id: @organization.id) and return
	rescue Exception => ex
		render :new
	end

	def show
		@organization = Organization.find( params[:id] )
	end

	def edit
		@organization = Organization.find( params[:id] )

	rescue Exception => ex
		redirect_to organizations_path, flash: "#{ex.message}"
	end

	def update
		@organization = Organization.find( params[:id] )
		@organization.update_attributes!( organization_params )

		flash[:success] = 'Yay!! Organization updated successfully!!'
		redirect_to organization_path(id: @organization.id) and return
	rescue Exception => ex
		render :new
	end

	private

	def organization_params
		params.require(:organization).permit( :name, :creator, :email, :mobile, :address, :organization_type, :products_sold,
																					:pan_tin_number, :is_store, :is_eco_friendly, :can_do_logistics )
	end
end
