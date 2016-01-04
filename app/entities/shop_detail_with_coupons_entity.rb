class ShopDetailWithCouponsEntity < ShopDetailEntity
  expose :active_coupons, using: CouponDetailEntity, as: :coupons
  expose :deactive_coupons, using: CouponDetailEntity, as: :past_coupons do |obj, options|
    obj.deactive_coupons.order(:created_at).limit(2)
  end
end
