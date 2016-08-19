class BookCategory < ActiveRecord::Base
	belongs_to :book 
	belongs_to :category

	belongs_to :barrowingbook
end
