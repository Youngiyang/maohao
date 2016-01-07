class Coupon < ActiveRecord::Base
  belongs_to :shop
  has_many :coupon_items

  def self.get_coupons_by_location lnt, lng, distance
    shops = Shop.get_shops_by_location lnt, lng, distance
    shops.present? ? shops.includes(:coupons)[rand(shops.size)].coupons : []
  end

  def is_coupon_grab_time?
    start_time_valid = self.start_time.present? ? (Time.now > self.start_time) : true
    end_time_valid = self.end_time.present? ? (Time.now < self.end_time) : true
    start_time_valid && end_time_valid
  end

  def is_valid_coupon_left?
    self.total - self.giveout > 0
  end
end
