class CreateShopClasses < ActiveRecord::Migration
  def change
    create_table :shop_classes do |t|
      t.string :name, null: false
      t.string :description, null: false, default: ''
      t.string :icon
      t.integer :parent_id, null: false, default: 0
      t.integer :sort_order, null: false, default: 1
      t.boolean :is_hot, null: false, default: false
      t.timestamps null: false
    end
  end
end
