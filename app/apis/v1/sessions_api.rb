module V1
  class SessionsAPI < Grape::API
    helpers V1::SharedParams

    params do
      use :mobile_password
    end
    post 'sessions' do
      user = User.find_by(mobile: params[:mobile])
      if user
        if user.authenticate(params[:password])
          if user.state == 1
            {message: '登录成功', auth_token: user.auth_token}
          else
            bad_request!('用户被禁用', code: 4000004)
          end
        else
          bad_request!('手机号或密码错误', code: 4000005)
        end
      else
        bad_request!('手机号未注册', code: 4000002)
      end
    end
  end
end
