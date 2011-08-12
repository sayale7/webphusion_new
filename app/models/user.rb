class User
	
  include Mongoid::Document
  include ActiveModel::SecurePassword
  
  field :email, :type => String
  field :password_digest, :type => String
  field :account_owner, :type => Boolean
  field :account_connections => Array
  field :admin, :type => Boolean
  
	has_one :account

	has_secure_password  
	
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  after_create :add_account
  before_destroy :destroy_account
  
  private 
  
  def add_account
  	if self.account_owner
  		account = Account.create(user_id: self.id)
  		self.add_to_set(:account_connections, account.id.to_s)
		end
  end
  
  def destroy_account
  	unless self.account.nil?
  		self.account.destroy
		end
  end
  
end
