class CouponItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :coupon
end
