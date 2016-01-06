module V1
  class UsersAPI < Grape::API
    helpers V1::SharedParams

    namespace 'user' do
      get '' do
        authenticate_by_token!
        present current_user, with: UserEntity
      end

      params do
        optional :sex, values: ['male', 'female', 'secret']
        at_least_one_of :nick_name, :sex, :residence, :avatar
      end
      post '' do
        authenticate_by_token!
        update_attrs = attributes_for_keys([:nick_name, :sex, :residence, :avatar])
        current_user.update!(update_attrs)
        present current_user, with: UserEntity
      end

      get 'qiniu_uptoken' do
        authenticate_by_token!
        {qiniu_uptoken: qiniu_uptoken, qiniu_domain: Rails.application.config.qiniu_domain}
      end

      params do
        requires :old_password
        requires :new_password
      end
      post 'reset_password' do
        authenticate_by_token!
        old_password = params[:old_password]
        new_password = params[:new_password]
        if current_user.authenticate(old_password)
          if new_password != old_password
            current_user.password = new_password
            current_user.reset_auth_token
            current_user.save!
            {message: '密码重置成功', auth_token: current_user.auth_token}
          else
            bad_request!('新旧密码一致', code: 4000006)
          end
        else
          bad_request!('原密码不正确', code: 4000007)
        end
      end

      params do
        use :mobile_password, :auth_code
      end
      post 'forget_password' do
        user = User.find_by(mobile: params[:mobile])
        if user.present?
          if AuthCode.valid_auth_code?(params[:mobile], 'forget_password', params[:auth_code])
            user.password = params[:password]
            user.reset_auth_token
            user.save!
            {message: '密码找回成功'}
          else
            bad_request!('验证码错误', code: 4000003)
          end
        else
          bad_request!('手机号未注册', code: 4000002)
        end
      end

      params do
        optional :coupon_type, type: Integer, values: [0, 1, 2], default: 0
      end
      get 'coupons' do
        authenticate_by_token!
        coupon_items = current_user.coupon_items
                                   .select('coupon_items.*, shop_evaluations.id as evaluation_id')
                                   .joins('left join shop_evaluations on coupon_items.id = shop_evaluations.coupon_item_id')

        if params[:coupon_type] != 0
          coupon_items = coupon_items.where(coupon_type: params[:coupon_type])
        end

        present coupon_items, with: CouponItemEntity
      end

      get 'collect_shops' do
        authenticate_by_token!
        collect_shops = current_user.collection_shops.includes(:active_coupons)
        present collect_shops, with: ShopListEntity, include_coupons: true
      end

      get 'shake_info' do
        authenticate_by_token!
        current_user.update_grab_numbers
        left = (3600 - Time.now.to_i + current_user.first_grab_time.to_i)
        {times: current_user.grab_numbers, seconds: current_user.grab_numbers == ENV["GRAB_TIME_LIMIT"].to_i ? -1 : left }
      end


    end

    namespace 'users' do
      params do
        use :mobile_password, :auth_code
      end
      post '' do
        if User.exists?(mobile: params[:mobile])
          bad_request!('手机号已注册', code: 4000001)
        else
          if AuthCode.valid_auth_code?(params[:mobile], 'sign_up', params[:auth_code])
            user = User.new(mobile: params[:mobile], password: params[:password])
            user.reset_auth_token
            user.save!
            {message: '注册成功'}
          else
            bad_request!('验证码错误', code: 4000003)
          end
        end
      end
    end
  end
end
