class SessionsController < ApplicationController
	def new  
	end  

	def create  
	  user = User.where(:email => params[:email]).first 
	  if user && user.authenticate(params[:password])  
	    session[:user_id] = user.id  
	    redirect_to root_url, :notice => "Erfolgreich eingeloggt!"  
	  else  
	  	flash[:alert] = "Falsche Email oder Passwort!"  
	    render "new"
	  end  
	end 

	def destroy  
	  session[:user_id] = nil  
	  redirect_to login_path, :notice => "Erfolgreich ausgeloggt!"  
	end
end
