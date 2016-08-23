class RemoveColumnCategoryIdPreference < ActiveRecord::Migration
  def change
  	remove_column :preferences,:category_id
  end
end
