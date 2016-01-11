class CreateRecommendedShops < ActiveRecord::Migration
  def change
    create_table :recommended_shops do |t|
      t.integer :shop_id, null: false
      t.string :image, null: false
      t.timestamps null: false
    end
  end
end
