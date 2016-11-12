class OrganizationsController < ActionController::Base
	before_action :authenticate_user!

	def new
		@organization = Organization.new
	end

	def create
		@organization = Organization.new( organization_params )
		@organization.creator_id = current_user.id
		@organization.save!

		redirect_to organization_path(id: @organization.id) and return
	rescue Exception => ex
		render :new
	end

	def show
		@organization = Organization.find( params[:id] )
	end

	def edit
	end

	def update
	end

	private

	def organization_params
		params.require(:organization).permit( :name, :creator, :email, :mobile, :organization_type, 
																					:pan_tin_number, :is_store, :is_eco_friendly, :can_do_logistics )
	end
end