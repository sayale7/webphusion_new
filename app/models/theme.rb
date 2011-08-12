class Theme
	include Mongoid::Document
	
	field :name, :type => String
	field :public, :type => Boolean, :default => false
	
	belongs_to :account
	
	validates_presence_of :name
end