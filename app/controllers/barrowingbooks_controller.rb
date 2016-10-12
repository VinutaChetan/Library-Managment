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
        if @barrowingbook.book.numbers_available != 0
		numbers_available = @barrowingbook.book.numbers_available 
		numbers = ( numbers_available - 1)
		@barrowingbook.book.update_attributes(:numbers_available => numbers)
	    
	    	

		end
		# @barrowingbook = Barrowingbook.all.where('id = ?',@barrowingbook.book_id)
		# @book.update_attribute(:numbers_available, @barrowingbook.numbers_available-1)
		
		if @barrowingbook.save
			redirect_to barrowingbooks_path
		else 
			render action: "new" 
		end
	end	




	def new
		
			@barrowingbook=current_user.barrowingbooks.new
			@barrowingbooks = current_user.barrowingbooks
		
	end	

	def show
		@book_reviews = Review.all
		#@barrowingbook=current_user.is_librarian? ? Barrowingbook.all : current_user.barrowingbooks.find(params[:id])
		@barrowingbook = Barrowingbook.find(params[:id])
		@bookrating=[]
		@reviews=Review.new
		current_user.barrowingbooks.each do |book|

			@bookrating.push(book)
		end	
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

		numbers_available = @barrowingbook.book.numbers_available 
		numbers = ( numbers_available+1)
		@barrowingbook.book.update_attributes(:numbers_available => numbers)
		
		Notification.bookreturned(@barrowingbook,current_user).deliver!

		redirect_to barrowingbooks_path,notice:"Returned the book"

	end	

	def mailtoreturn
		@barrowingbook =Barrowingbook.find(params[:barrowingbook_id])

		Notification.booktoreturn(@barrowingbook,current_user).deliver!

		redirect_to barrowingbooks_path,notice:"Successfully send the mail to Return the book"
	end

	def announce
	mail_ids=[]
	
	@barrowingbook=Barrowingbook.all.where(due_date: Date.today,date_returned: nil)
	
	@barrowingbook.each do |book|

		mail_ids.push(book.user.email)
	end	
	
	mail_ids=mail_ids.join(",")

	Notification.announcement(mail_ids,current_user).deliver!
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



