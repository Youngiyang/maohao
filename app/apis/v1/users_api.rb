module V1
  class UsersAPI < Grape::API
    helpers V1::SharedParams

    namespace :user do
      get '' do
        authenticate_by_token!
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
            render_api_error!('新旧密码一致', 400)
          end
        else
          render_api_error!('原密码不匹配', 400)
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
            render_api_error!('验证码错误', 400)
          end
        else
          render_api_error!('手机号未注册', 400)
        end
      end
    end

    namespace 'users' do
      params do
        use :mobile_password, :auth_code
      end
      post '' do
        if User.exists?(mobile: params[:mobile])
          render_api_error!('手机号已注册', 400)
        else
          if AuthCode.valid_auth_code?(params[:mobile], 'sign_up', params[:auth_code])
            user = User.new(mobile: params[:mobile], password: params[:password])
            user.reset_auth_token
            user.save!
            {message: '注册成功'}
          else
            render_api_error!('验证码错误', 400)
          end
        end
      end
    end
  end
end
