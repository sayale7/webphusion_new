class UsersController < ApplicationController
	
	def show
		@user = User.find(params[:id])
	end
	
	def new  
    @user = User.new  
  end  
  
  def create  
    @user = User.new(params[:user])  
    if @user.save  
      redirect_to login_path, :notice => "Account erfolgreich angelegt!"  
    else  
      render "new"  
    end  
  end
  
  def edit
  	@user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
  	if password_confirmed? and @user.update_attributes(params[:user])
  		 redirect_to root_path, :notice => "Daten erfolgreich gespeichert!"  
		else
			edit 
			render "edit"
		end
  end
  
  private
  
  def password_confirmed?
  	if params[:user][:password].blank?
  		true
		else
			if params[:user][:password].to_s.eql? params[:user][:password_confirmation].to_s
				true
			else					
				flash[:alert] = "Passwort und Passwortbestaetigung stimmen nicht ueberein!"
				false
			end
		end
  end
  
end
