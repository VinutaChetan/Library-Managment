class UsersController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource
	def index
		@user=current_user
	end	

	def preference
		@user = current_user
	end

	def update
		@user=current_user
		if @user.update_attributes(user_params)
			redirect_to users_path(@users_id),notice:"successfully updated"
		else
			render action :"edit"
		end	
	end

	def recomended
		@user = current_user
	end

	
end

private
		def user_params		
			params[:user].permit(:user_id,:category_ids => [])
		end	

