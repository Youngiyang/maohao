module V1
  class CouponsAPI < Grape::API
    namespace 'coupons' do
      get ':id' do
        coupon = Coupon.find(params[:id])
        present coupon, with: CouponDetailWithShopEntity
      end

      get 'shake_grab' do
        authenticate_by_token!
        if current_user.grab_valid?
          if shake_grab 50
            coupons = Coupon.get_coupons_by_location lnt, lng, params[:distance]
            coupon = coupons[rand(coupons.count)]
            present coupon, with: CouponDetailWithShopEntity
          else
            bad_request!('未摇到，请重试')
          end
        else
          bad_request!('您已没有可用次数，请稍候重试')

      get ':id/grab' do
        authenticate_by_token!
        coupon = Coupon.find(params[:id])
        if coupon.is_coupon_grab_time? && current_user.is_coupon_out_of_limit?(coupon)
          current_user.save_coupon_item_redundancy coupon
          coupon.increment!(:giveout)
          present coupon, with: CouponDetailWithShopEntity
        else
          bad_request!('优惠券不可用')
        end
      end
    end
  end
end
