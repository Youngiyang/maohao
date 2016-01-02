module V1
  class CouponsAPI < Grape::API
    namespace 'coupons' do
      get ':id' do
        coupon = Coupon.find(params[:id])
        present coupon, with: CouponDetailWithShopEntity
      end

      get ':id/grab' do
        authenticate_by_token!
        coupon = Coupon.find(params[:id])
        if coupon.is_coupon_grab_time? && current_user.is_coupon_out_of_limit?(coupon)
          present coupon, with: CouponDetailWithShopEntity
        else
          bad_request!('优惠券不可用')
        end
      end
    end
  end
end
