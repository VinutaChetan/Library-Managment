class CreateBarrowingbooks < ActiveRecord::Migration
  def change
    create_table :barrowingbooks do |t|
    	t.integer :user_id
    	t.integer :book_id
    	t.date :barrowing_date
    	t.date :due_date
    	t.date :date_returned

      t.timestamps
    end
  end
end
