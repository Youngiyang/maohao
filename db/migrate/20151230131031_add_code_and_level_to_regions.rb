class AddCodeAndLevelToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :encoding, :string, null: false
    add_column :regions, :depth, :integer, null:false
    add_index :regions, [:name, :parent_id], unique: true
  end
end
