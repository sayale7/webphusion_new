module InvitationsHelper
	
	def all_users_without_me_and_added
		User.excludes(id: current_user.id, account_connections: current_user.account.id.to_s).collect {|u| u.email }
	end
	
end
