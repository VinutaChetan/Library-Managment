class AddColumnCategoryIdToPreference < ActiveRecord::Migration
  def change
  	add_column :preferences,:category_id,:integer
  end
end
