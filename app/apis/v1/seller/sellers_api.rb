module V1
  module Seller
    class SellersAPI < Grape::API
      get '' do
        authenticate_by_token!
        present current_user, with: SellerEntity
      end

      params do
        requires :coupon_sn
      end
      post 'ensure_coupon' do
        authenticate_by_token!
        user_coupon = CouponItem.find_by(coupon_sn: params[:coupon_sn])
        if user_coupon
          coupon = user_coupon.coupon
          if coupon.shop.user_id != current_user.id
            bad_request!('该优惠券不属于该商家')
          elsif coupon.end_time < Time.now
            bad_request!('优惠劵已过期')
          elsif user_coupon.state == 1
            bad_request!('优惠券已使用！')
          else
            user_coupon.update_attribute(:state, 1)
            user_coupon.coupon.increment!(:used)
            { message: '成功使用优惠券' }
          end
        else
          bad_request!('该优惠券无效')
        end
      end
    end
  end
end
