class CouponItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :coupon

  scope :un_used, ->{where(state: 0)}

end
