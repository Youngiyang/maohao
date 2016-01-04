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
        if coupon.is_coupon_grab_time? && current_user.is_coupon_out_of_limit?(coupon) && coupon.is_valid_coupon_left?
          current_user.save_coupon_item_redundancy coupon
          coupon.increment!(:giveout)
          present coupon, with: CouponDetailWithShopEntity
        else
          bad_request!('优惠券不可用', code: 200001)
        end
      end
    end
  end
end
