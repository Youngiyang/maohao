module V1
  class CouponsAPI < Grape::API
    namespace 'coupons' do
      get ':id' do
        coupon = Coupon.find(params[:id])
        present coupon, with: CouponDetailWithShopEntity
      end
    end
  end
end
