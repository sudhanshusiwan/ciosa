class Organization < ActiveRecord::Base
	ORGANIZATION_TYPE_STORE = 'Store'
	ORGANIZATION_TYPE_NGO = 'NGO'

	has_many :users
	belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

	validates :name, :creator, :email, :mobile, :organization_type, :pan_tin_number,
						:is_store, :is_eco_friendly, :can_do_logistics, presence: true
	validates :email, :mobile, uniqueness: true

	scope :all_organizations, -> { all }
  scope :approved, -> { where( is_approved: true ) }
  scope :unapproved, -> { where( is_approved: false ) }

	def approved?
    self.is_approved == true
  end

  def approve!
    self.update_attributes!(is_approved: true)
  end

  def declined?
    self.is_approved == false
  end

  def decline!
    self.update_attributes!(is_approved: false)
  end
end