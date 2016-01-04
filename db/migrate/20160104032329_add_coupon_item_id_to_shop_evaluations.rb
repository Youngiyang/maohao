class AddCouponItemIdToShopEvaluations < ActiveRecord::Migration
  def change
    add_column :shop_evaluations, :coupon_item_id, :integer, null: false, unique: true
  end
end
