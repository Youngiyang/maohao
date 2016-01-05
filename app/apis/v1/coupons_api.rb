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
        if coupon.is_coupon_grab_time?
          if current_user.is_coupon_out_of_limit?(coupon)
            if coupon.is_valid_coupon_left?
              current_user.save_coupon_item_redundancy coupon
              coupon.increment!(:giveout)
              present coupon, with: CouponDetailWithShopEntity
            else
              bad_request!('优惠券已经抢光', code: 4002004)
            end
          else
            bad_request!('用户优惠券数量超过限制', code: 4002003)
          end
        else
          bad_request!('抢优惠券时间不正确', code: 4002002)
        end
      end
    end
  end
end
