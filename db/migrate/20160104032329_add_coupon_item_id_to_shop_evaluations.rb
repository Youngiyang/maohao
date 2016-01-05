class AddCouponItemIdToShopEvaluations < ActiveRecord::Migration
  def change
    add_column :shop_evaluations, :coupon_item_id, :integer, null: false, unique: true
    change_column_null :shop_evaluations, :user_nick_name, true
  end
end
