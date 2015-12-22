class AddonCouponEntity < Grape::Entity
  expose :id, :name, :cc_type, :min_amount
  expose :cheap, if: lambda {|coupon, opotions| coupon.cc_type == 1}
  expose :discount, if: lambda {|coupon, opotions| coupon.cc_type == 2}

end
