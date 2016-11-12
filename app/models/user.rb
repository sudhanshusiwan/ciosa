class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization

  validates :email, :mobile, :name, :user_type, presence: true

  before_validation :update_user_type

  USER_TYPE_BUYER = 'buyer'
  USER_TYPE_SELLER = 'seller'
  USER_TYPE_ADMIN = 'admin'

  def self.current=(user)
    Thread.current['user'] = user
  end

  def self.current
    Thread.current['user']
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
