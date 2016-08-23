class BarrowingbooksController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		#@barrowingbooks = Barrowingbook.all
		
		@barrowingbooks=current_user.is_librarian? ? Barrowingbook.all : current_user.barrowingbooks
		
		#@clients =current_user.is_admin? ? Client.all : current_user.clients 
	end
	
	def create
		@barrowingbook = Barrowingbook.new(barrowingbook_params)
		@barrowingbook.barrowing_date=Date.today
		@barrowingbook.due_date=Date.today+5.days

		
		if @barrowingbook.save
			redirect_to barrowingbooks_path
		else 
			render action: "new"
		end
		
	end

	def new
		
		@barrowingbook=current_user.barrowingbooks.new

		
	end	

	def show
		#@barrowingbook=current_user.is_librarian? ? Barrowingbook.all : current_user.barrowingbooks.find(params[:id])
		@barrowingbook = Barrowingbook.find(params[:id])
	end

	def update
		@barrowingbook= current_user.barrowingbooks.find(params[:id])	
		if @barrowingbook.update_attributes(barrowingbook_params)
			redirect_to barrowingbooks_path(@barrowingbook.id), notice:"successfully updated"
		else
		render action :"edit"
	end
	end	


	def edit
		@barrowingbook = current_user.barrowingbooks.find(params[:id])		
	end

	def destroy
	@barrowingbook =Barrowingbook.find(params[:id])
	@barrowingbook.destroy
		redirect_to barrowingbooks_path, notice:"Successfully deleted "
	end	

	def returned
		#@barrowingbook =current_user.is_librarian? ? Barrowingbook.all : current_user.barrowingbooks.find(params[:barrowingbook_id])
		
		@barrowingbook =Barrowingbook.find(params[:barrowingbook_id])
		@barrowingbook.update_attributes(date_returned: Date.today)
		

		Notification.bookreturned(@barrowingbook,current_user).deliver!

		redirect_to barrowingbooks_path,notice:"Returned the book"

	end	

	def mailtoreturn
		@barrowingbook =Barrowingbook.find(params[:barrowingbook_id])
		Notification.booktoreturn(@barrowingbook,current_user).deliver!

		redirect_to barrowingbooks_path,notice:"Successfully send the mail to Return the book"
	end



	def recentbook
		#@barrowingbooks =current_user.is_librarian? ? Barrowingbook.all : current_user.barrowingbooks
		 @barrowingbooks =current_user.is_librarian? ? Barrowingbook.all : current_user.barrowingbooks.last(3)
	end
	
	private
		def barrowingbook_params		
			params[:barrowingbook].permit(:book_id,:user_id,:email,:barrowed_date,:date_returned,:price)
		end	


	
end




