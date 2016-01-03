module V1
  class CouponsAPI < Grape::API
    helpers V1::SharedParams

    namespace 'coupons' do
      params do
        use :location_params
      end

      get 'shake_grab' do
        authenticate_by_token!
        if current_user.grab_valid?
          # set default as 50 percent
          if randomly_return 50
            coupons = Coupon.get_coupons_by_location params[:lnt], params[:lng], params[:distance]
            coupon = current_user.get_valid_shake_grab_coupon coupons.map(&:id), coupons
            if coupon
              current_user.save_coupon_item_redundancy coupon
              coupon.increment!(:giveout)
              current_user.update_after_shake_grab
              present coupon, with: CouponDetailWithShopEntity 
            else
              bad_request!('目前用户无可以用优惠券')
            end
          else
            bad_request!('未摇到，请重试')
          end
        else
          bad_request!('您已没有可用次数，请稍候重试')
        end
      end

      get ':id/grab' do
        authenticate_by_token!
        coupon = Coupon.find(params[:id])
        if coupon.is_coupon_grab_time? && !current_user.is_coupon_out_of_limit?(coupon)
          current_user.save_coupon_item_redundancy coupon
          coupon.increment!(:giveout)
          present coupon, with: CouponDetailWithShopEntity
        else
          bad_request!('优惠券不可用')
        end
      end

      get ':id' do
        coupon = Coupon.find(params[:id])
        present coupon, with: CouponDetailWithShopEntity
      end
    end
  end
end
