class Coupon < ActiveRecord::Base
  belongs_to :shop
  has_many :coupon_items

  def self.get_coupons_by_location lnt, lng, distance
    shops = Shop.get_shops_by_location lnt, lng, distance
    shops.map(&:coupons).flatten
  end

  def is_coupon_grab_time?
    Time.now > start_grab_time && Time.now < end_grab_time
  end
end
