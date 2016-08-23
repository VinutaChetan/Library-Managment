class Category < ActiveRecord::Base
	#join table
	has_many :book_categories
	has_many :books, through: :book_categories
	
	
	has_many :preferences
	has_many :users,through: :preferences

	validates_presence_of :name,scope: :user_id
end
