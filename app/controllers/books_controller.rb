class BooksController < ApplicationController
	load_and_authorize_resource

	def index
		@books=Book.all
	end
	
	def new
		@book=Book.new
		@category =Category.new
	end	

	def create
		@book =Book.new(book_params)
		if @book.save
			redirect_to books_path
		else
			render action: "new"
		end
	end

	# def create
	# 	@barrowingbook = Barrowingbook.new(barrowingbook_params)
	# 	if @barrowingbook.save
	# 		redirect_to books_path(@barrowingbook.book_id), notice:"Successfully created"
	# 	end
	# end	


	def show
		@book = Book.find(params[:id])

	end

	def destroy
	@book =Book.find(params[:id])
	@book.destroy
		redirect_to books_path, notice:"Successfully deleted #{@book.name}"
	end		

	

	def edit
		@book = Book.find(params[:id])		
	end
	
	def update
		@book= Book.find(params[:id])	
		if @book.update_attributes(book_params)
			redirect_to book_path(@book.id), notice:"successfully updated"
		else
		render action :"edit"
	end
	end	

	

	private
	def book_params
		params[:book].permit(:name,:price,:author_name,:pages,:description,:isbn,:rating,:borrow_limit,:numbers_available,category_ids:[])
	end	
end

