class User < ActiveRecord::Base
	has_many :books
	has_many :categories
	has_many :barrowingbooks
  has_many :reviews
  has_many :preferences
  has_many :categories ,through: :preferences

  



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   def is_librarian?
  	return true if self.role == "librarian"
  end	      
end