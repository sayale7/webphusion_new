class WebsitesController < ApplicationController

  def index
    @websites = Website.all
  end


  def new
    @website = Website.new
  end


  def edit
    @website = Website.find(params[:id])
  end


  def create
    @website = Website.new(params[:website])
		if @website.save
			redirect_to root_path, :notice => t('website.messages.created')
		else
			render :action => :new
		end
  end


  def update
    @website = Website.find(params[:id])
		if @website.update_attributes(params[:website])
			redirect_to root_path, :notice => t('website.messages.updated')
		else
			render :action => :edit
		end
  end


  def destroy
    @website = Website.find(params[:id])
    @website.destroy
		redirect_to root_path, :notice => t('website.messages.destroyed')
  end
end
