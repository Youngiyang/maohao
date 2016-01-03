class Coupon < ActiveRecord::Base
  belongs_to :shop
  has_many :coupon_items

  def self.get_coupons_by_location lnt, lng, distance
    shops = Shop.get_shops_by_location lnt, lng, distance
    shops.map(&:coupons).flatten
  end
end
