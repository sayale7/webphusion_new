class ThemesController < ApplicationController
	
	def new
		@theme = Theme.new
	end
	
	def edit
		@theme = Theme.find(params[:id])		
	end
	
	def create
		@theme = Theme.new(params[:theme])
		if @theme.save
			redirect_to root_path, :notice => t('theme.messages.created')
		else
			render :action => :new
		end
	end
	
	def update
		@theme = Theme.find(params[:id])
		if @theme.update_attributes(params[:theme])
			redirect_to root_path, :notice => t('theme.messages.updated')
		else
			render :action => :edit
		end
	end
	
  def destroy
    @theme = Theme.find(params[:id])
    @theme.destroy
		redirect_to root_path, :notice => t('theme.messages.destroyed')
  end
	
end