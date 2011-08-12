class Account
	include Mongoid::Document
  belongs_to :user
	has_many :websites
	has_many :themes
  
  before_destroy :unlink_users
  
  def guests
		users = Array.new
		User.all.each do |user|
			unless user[:account_connections].to_a.empty?
				user.account_connections.each do |account_id|
					if account_id == self.id.to_s
						users << user
					end
				end
			end
		end
		users.uniq - User.find(self.user_id).to_a
	end
	
	private
	
	def unlink_users
		User.all.each do |user|
			unless user[:account_connections].to_a.empty?
				added_users = user.account_connections - self.id.to_s.to_a
				user.write_attributes( account_connections: added_users)
				user.save
			end
		end
	end
	
end