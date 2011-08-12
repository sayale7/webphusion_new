class InvitationsController < ApplicationController
	
	def new
		@user = User.new
	end
	
	def destroy
		@user = User.find(params[:id])
		if !@user.account_owner and @user.account_connections.size() == 1			
			@user.destroy
		else
			added_users = @user.account_connections - current_user.account.id.to_s.to_a
			@user.write_attributes( account_connections: added_users)
			@user.save
		end
		redirect_to edit_user_path(current_user), :notice => t('invitation.messages.disconnected')
	end
	
end
