class CouponDetailWithShopEntity < CouponDetailEntity
  expose :shop do |obj, options|
    ShopDetailEntity.new(obj.shop, options)
  end
end
