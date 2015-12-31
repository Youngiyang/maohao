class AddImageToCouponsAndAddCouponImageToCouponItems < ActiveRecord::Migration
  def change
    add_column :coupons, :image, :string, null: false
    add_column :coupon_items, :coupon_image, :string, null: false
  end
end
