class AddCouponItemIdToShopEvaluations < ActiveRecord::Migration
  def change
    add_column :shop_evaluations, :coupon_item_id, :integer, null: false, unique: true
    change_colum :shop_evaluations, :user_nick_name, null: true
  end
end
