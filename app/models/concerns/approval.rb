module Approval
	extend ActiveSupport::Concern

	def self.included(base)
    base.class_eval do
      scope :approved, -> { where( is_approved: true ) }
  		scope :unapproved, -> { where( is_approved: false ) }
    end
  end

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