class ReviewsController < ApplicationController
	
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@reviews = Review.all
	end
	
	def create
		@review =Review.new(review_params)
		@review.user_id=current_user.id

		if @review.save
			redirect_to reviews_path
		else
			render action: "new"	
		end	
	end

	def new
		@review= Review.new
	end

	def show
		@review = Review.find(params[:id])
	end
	
	def destroy
		@review = Review.find(params[:id])
		@review.destroy

		redirect_to reviews_path,notice:"Successfully Deleted Review"
	end	

	
	private
	def review_params
		params[:review].permit(:user_id,:book_id,:body,:rating,:barrowingbook_id)	
	end	
end
