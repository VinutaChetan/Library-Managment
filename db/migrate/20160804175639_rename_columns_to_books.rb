class RenameColumnsToBooks < ActiveRecord::Migration
  def change
  	rename_column :books,:contents,:category_name
  end
end
