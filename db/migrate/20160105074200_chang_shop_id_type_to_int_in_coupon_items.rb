class ChangShopIdTypeToIntInCouponItems < ActiveRecord::Migration
  def change
    change_column :coupon_items, :shop_id, 'integer USING CAST(shop_id AS integer)'
  end
end
