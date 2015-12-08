class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name, null: false
      t.integer :parent_id, null: false, default: 0
      t.integer :sort_order, null: false, default: 1
      t.timestamps null: false
    end
    add_index :regions, :name
    add_index :regions, :parent_id
  end
end
