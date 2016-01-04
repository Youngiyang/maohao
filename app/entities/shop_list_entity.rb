class ShopListEntity < ShopDetailEntity
  expose :active_coupons, using: CouponBasicEntity, as: :coupons
end
