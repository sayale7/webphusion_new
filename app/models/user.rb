class User
	
  include Mongoid::Document
  include ActiveModel::SecurePassword
  field :email, :type => String
  field :password_digest, :type => String

  attr_accessible :email, :password, :password_confirmation

	has_secure_password  
	
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  
end
