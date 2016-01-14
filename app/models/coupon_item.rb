class CouponItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :coupon

  scope :un_used, ->{where(state: 0)}

  def self.get_coupon_sn
    loop do
      nums = (0..9).to_a
      prefix = Time.now.strftime('%y%m%d')
      postfix = nums.sample(6).join
      coupon_sn = prefix + postfix
      return coupon_sn unless CouponItem.exists?(coupon_sn: coupon_sn)
    end
  end
end
