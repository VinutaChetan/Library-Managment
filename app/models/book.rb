class Book < ActiveRecord::Base
	#join table
	has_many :book_categories
	has_many :categories, through: :book_categories

	has_many :barrowingbooks
	has_many :reviews

	
	validates_presence_of :name,:price,:author_name,:pages,:description,:isbn,:rating,:borrow_limit,:numbers_available
	validates_length_of :description, minimum:10
	validates_length_of :rating, maximum:5
end
