class ShopDetailEntity < ShopListEntity
  unexpose :active_coupons
  expose :coupons, if: {with_coupons: true}, using: CouponDetailEntity
end
