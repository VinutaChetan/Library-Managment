class AddBarrowingLimitToUser < ActiveRecord::Migration
  def change
  	add_column :users,:barrowing_limit,:integer
  end
end
