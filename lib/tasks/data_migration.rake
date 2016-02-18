namespace :data_migration do
  desc "add coupon_image to coupon_items"
  task :add_coupon_image_to_coupon_items => [:environment] do
    coupon_items = CouponItem.all
    coupon_items.each do |coupon_item|
      coupon = Coupon.find(coupon_item.coupon_id)
      coupon_item.update_attribute(:coupon_image, coupon.image)
    end
  end
end
