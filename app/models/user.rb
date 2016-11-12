class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization

  validates :email, :mobile, :name, :user_type, presence: true
  validates :email, :mobile, uniqueness: true

  before_validation :update_user_type

  USER_TYPE_BUYER = 'buyer'
  USER_TYPE_SELLER = 'seller'
  USER_TYPE_ADMIN = 'admin'

  has_many :cart_products
  has_many :orders

  scope :all_users, -> { all }
  scope :approved_users, -> { where( is_approved: true ) }
  scope :unapproved_users, -> { where( is_approved: false ) }


  def is_buyer?
    USER_TYPE_BUYER == self.user_type
  end

  def is_seller?
    USER_TYPE_SELLER == self.user_type
  end

  def is_admin?
    USER_TYPE_ADMIN == self.user_type
  end

  def approved?
    self.is_approved == true
  end

  def approve!
    self.update_attributes!(is_approved: true)
  end

  def un_approved?
    self.is_approved.blank?
  end

  def declined?
    self.is_approved == false
  end

  def decline!
    self.update_attributes!(is_approved: false)
  end


  private

  def update_user_type
  	return true if USER_TYPE_ADMIN == self.user_type

  	if self.organization_id.present?
  		self.user_type = USER_TYPE_SELLER
  	else
  		self.user_type = USER_TYPE_BUYER
  	end
  end
end
