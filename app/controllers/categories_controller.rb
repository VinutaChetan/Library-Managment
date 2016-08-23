class CategoriesController < ApplicationController

	before_action :authenticate_user!
	load_and_authorize_resource


	def index
		@categories = Category.all
	end	

	def new
		@category= Category.new
	end
	
	def create
		@category =Category.new(category_params)

		#add this for personalization of app
		@category.user_id=current_user.id

		if @category.save
			redirect_to categories_path
		else
			render action:"new"
		end
	end

	def show
		@category =Category.find(params[:id])
	end	

	def destroy
	@category =Category.find(params[:id])
	@category.destroy
		redirect_to categories_path, notice:"Successfully deleted #{@category.name}"
	end		

	def edit
		@category = Category.find(params[:id])		
	end
	
	def update
		@category= Category.find(params[:id])	
		if @category.update_attributes(category_params)
			redirect_to category_path(@category.id), notice:"successfully updated"
		else
		render action :"edit"
	end
	end	
	
	

	
	private
	def category_params
		params[:category].permit(:name)
	end
end
