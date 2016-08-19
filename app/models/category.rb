class Category < ActiveRecord::Base
	#join table
	has_many :book_categories
	has_many :books, through: :book_categories


	validates_presence_of :name,scope: :user_id
end
