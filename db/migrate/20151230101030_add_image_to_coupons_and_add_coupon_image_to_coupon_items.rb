class AddImageToCouponsAndAddCouponImageToCouponItems < ActiveRecord::Migration
  def change
    add_column :coupons, :image, :string, null: false, default: ''
    add_column :coupon_items, :coupon_image, :string, null: false, default: ''
  end
end
