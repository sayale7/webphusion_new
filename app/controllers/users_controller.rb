class UsersController < ApplicationController
	
	def show
		@user = User.find(params[:id])
	end
	
	def new  
    @user = User.new  
  end  
  
  def create 
  	if session[:user_id].nil?
  		@user = User.new(params[:user])
  		if @user.save
  			redirect_to login_path, :notice => t('user.messages.created')
			else
				render :action => :new
			end
		else
	  	@user = User.where(:email => params[:user][:email]).first
	  	add_if_exists_or_create_and_add
  	end
  end
  
  def edit
  	@user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
  	if password_confirmed? and @user.update_attributes(params[:user])
  		 redirect_to root_path, :notice => t('user.messages.created')  
		else
				render :action => :edit
		end
  end
  
  def destroy
  	user = User.find(params[:id])
  	session[:user_id] = nil
  	if user.destroy
  		redirect_to login_path, :notice => t('user.messages.destroyed')
		else
			edit
			render "edit"
		end
  end
  
  private
  
  def add_if_exists_or_create_and_add
  	unless @user.nil?
  		add_existing_user_to_account
		else
			@user = User.new(params[:user])
			add_user
  	end
  end
  
  def add_user
		if @user.save and @user.add_to_set(:account_connections, current_user.account.id.to_s)
			redirect_to edit_user_path(current_user.id), :notice => t('user.messages.added_user_to_account')
		else
			redirect_to edit_user_path(current_user.id), :notice => t('user.messages.could_not_add_user_to_account')
		end
  end
  
  def add_existing_user_to_account
  	unless session[:user_id].nil?
	  	if @user.id == current_user.id
	  		redirect_to new_invitation_path(:existing => false), :notice => t('user.messages.dont_add_yourself')
			elsif @user.account_connections.include?(current_user.account.id)
				redirect_to new_invitation_path(:existing => false), :notice => t('user.messages.allready_added')
			else
				if @user.add_to_set(:account_connections, current_user.account.id.to_s)
					redirect_to edit_user_path(current_user.id), :notice => t('user.messages.added_user_to_account')
				else
					redirect_to edit_user_path(current_user.id), :notice => t('user.messages.could_not_add_user_to_account')
				end
			end
		else
			redirect_to new_user_path, :notice => t('user.messages.email_exists')
		end
	end
  
  def password_confirmed?
  	if params[:user][:password].blank?
  		true
		else
			if params[:user][:password].to_s.eql? params[:user][:password_confirmation].to_s
				true
			else					
				flash[:alert] = t('user.messages.password_and_confirmation_dont_match')
				false
			end
		end
  end
  
end
