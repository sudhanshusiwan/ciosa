class Organization < ActiveRecord::Base
  include Approval

	ORGANIZATION_TYPE_STORE = 'Store'
	ORGANIZATION_TYPE_NGO = 'NGO'

	has_many :users
	belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

	validates :name, :creator, :email, :mobile, :organization_type, :pan_tin_number,
						:is_store, :is_eco_friendly, :can_do_logistics, presence: true
	validates :email, :mobile, uniqueness: true

	scope :all_organizations, -> { all }
end