class RemoveColumnBorrowLimitFromBooks < ActiveRecord::Migration
  def change
  	remove_column :books,:borrow_limit
  end
end
