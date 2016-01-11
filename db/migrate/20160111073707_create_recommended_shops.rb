class CreateRecommendedShops < ActiveRecord::Migration
  def change
    create_table :recommended_shops do |t|
      t.integer :shop_id, null: false
      t.string :image, null: false
      # 1为推荐，2为取消推荐
      t.integer :state, null: false, default: 1
      t.timestamps null: false
    end
  end
end
