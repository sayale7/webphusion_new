module ApplicationHelper
	
	def as_boolean(obj)
		%w(true t 1 y).include?(obj.to_s.downcase.strip)
	end
	
	def guest_accounts
		accounts = Array.new
		current_user.account_connections.each do |account_id|
			accounts << Account.find(account_id)
		end
		accounts.uniq - current_user.account.to_a
	end
	
end
