class Website
	
  include Mongoid::Document
  
  field :name, :type => String
  
  belongs_to :account
  
  validates_presence_of :name
  
end
