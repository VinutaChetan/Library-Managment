class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
    	t.string :name
    	t.float :price
    	t.string :author_name
    	t.integer :pages
    	t.text :description
    	t.text :contents
    	t.integer :isbn
    	t.integer :rating
    	t.integer :borrow_limit 
    	t.integer :numbers_available
      t.timestamps
    end
  end
end
