class Product < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'

  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many :orders

  validates :name, :price, :description, :creator_id, presence: true

  scope :all_products, -> { all }
  scope :approved, -> { where( approval_status: true  )}
  scope :unapproved, -> { where( approval_status: false  )}

  has_attached_file :image, styles: {thumb: '250x250>', medium: '400x400>'}
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png image/gif)

  def approved?
    self.approval_status == true
  end

  def approve!
    self.update_attributes!(approval_status: true)
  end

  def un_approved?
    self.approval_status.blank?
  end

  def declined?
    self.approval_status == false
  end

  def decline!
    self.update_attributes!(approval_status: false)
  end
end
