class Barrowingbook < ActiveRecord::Base
	has_many :book_categories

	belongs_to :book
	belongs_to :user
	
	validates_presence_of :book_id,:barrowing_date

end
