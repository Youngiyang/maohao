module V1
  class CouponsAPI < Grape::API
    helpers V1::SharedParams

    namespace 'coupons' do
      params do
        use :latlng
      end
      post 'shake_grab' do
        authenticate_by_token!
        recover_time = ENV['GRAB_RECOVER_TIME'].to_i
        shake_info = {times: current_user.grab_numbers, seconds: (recover_time - Time.now.to_i + current_user.first_grab_time.to_i)}
        if current_user.grab_valid?
          current_user.update_after_shake_grab
          shake_info = {times: current_user.grab_numbers, seconds: (recover_time - Time.now.to_i + current_user.first_grab_time.to_i)}
          # set default as 50 percent
          if randomly_return ENV['GRAB_PROBABILITY'].to_i
            coupons = Coupon.get_nearby_effective_coupons_by_random(params[:lng], params[:lat], ENV['GRAB_DISTANCE']).limit(1)
            coupon = coupons[0] if coupons.present?
            if coupon && coupon.is_valid_coupon_left? && current_user.is_coupon_out_of_limit?(coupon)
              coupon_item =  current_user.save_coupon_item_redundancy coupon
              coupon.increment!(:giveout)
              {coupon_item: CouponItemEntity.new(coupon_item), shake_info: shake_info}
            else
              bad_request!('无有效优惠券', code: 4002005, shake_info: shake_info)
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
              coupon_item = current_user.save_coupon_item_redundancy coupon
              coupon.increment!(:giveout)
              present coupon_item, with: CouponItemEntity
            else
              bad_request!('优惠券已经抢光', code: 4002004)
            end
          else
            bad_request!('该优惠券每人限抢' + coupon.perlimit.to_s + '张', code: 4002003)
          end
        else
          bad_request!('抢优惠券时间不正确', code: 4002002)
        end
      end

      get ':id' do
        coupon = Coupon.find(params[:id])
        present coupon, with: CouponDetailWithShopEntity, user: current_user
      end
    end
  end
end
