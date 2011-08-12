class SessionsController < ApplicationController
	def new  
	end  

	def create  
	  user = User.where(:email => params[:email]).first 
	  if user && user.authenticate(params[:password])  
	    session[:user_id] = user.id  
	    redirect_to root_url, :notice => t('session.messages.logged_in')
	  else  
	  	flash[:alert] = t('session.messages.wrong_credentials')
	    render "new"
	  end  
	end 

	def destroy  
	  session[:user_id] = nil  
	  redirect_to login_path, :notice => t('session.messages.logged_out')
	end
end
