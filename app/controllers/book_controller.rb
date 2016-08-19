class BookController < ApplicationController

	load_and_authorize_resource

  def categories
  	@categories =Category.all
  end

  def books
  	@books = Book.all 
  end
end
