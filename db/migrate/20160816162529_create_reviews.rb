class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    	t.integer :user_id
    	t.integer :book_id 
    	t.text :body
    	t.float :rating
      t.timestamps
    end
  end
end
