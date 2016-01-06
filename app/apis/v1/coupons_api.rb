module V1
  class CouponsAPI < Grape::API
    helpers V1::SharedParams

    namespace 'coupons' do
      params do
        use :lntlng
      end

      post 'shake_grab' do
        authenticate_by_token!
        shake_info = {times: current_user.grab_numbers, seconds: (3600 - Time.now.to_i + current_user.first_grab_time.to_i)}
        if current_user.grab_valid?
          shake_info[:times] = shake_info[:times] - 1
          # set default as 50 percent
          current_user.update_after_shake_grab
          if randomly_return 50
            coupons = Coupon.get_coupons_by_location params[:lnt], params[:lng], ENV['GRAB_DISTANCE']
            coupon = current_user.get_valid_shake_grab_coupon(coupons) if coupons.present?
            if coupon
              current_user.save_coupon_item_redundancy coupon
              coupon.increment!(:giveout)
              {coupon: CouponDetailWithShopEntity.new(coupon), shake_info: shake_info}
            else
              bad_request!('未摇到，请重试', code: 4002006, shake_info: shake_info)
            end
          else
            bad_request!('未摇到，请重试', code: 4002006, shake_info: shake_info)
          end
        else
          bad_request!('您已没有可用次数，请稍候重试', code: 4002007, shake_info: shake_info)
        end
      end

      post ':id/grab' do
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

      get ':id' do
        coupon = Coupon.find(params[:id])
        present coupon, with: CouponDetailWithShopEntity
      end
    end
  end
end
