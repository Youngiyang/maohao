module V1
  class UsersAPI < Grape::API
    helpers V1::SharedParams

    namespace :user do
      get '' do
        authenticate_by_token!
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
            {message: '密码重置成功'}
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
            {message: '密码找回成功'}
          else
            bad_request!('验证码错误', code: 4000003)
          end
        else
          bad_request!('手机号未注册', code: 4000002)
        end
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
