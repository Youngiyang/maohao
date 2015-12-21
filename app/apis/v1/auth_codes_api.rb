module V1
  class AuthCodesAPI < Grape::API
    helpers V1::SharedParams

    params do
      use :mobile, :auth_code_type
    end
    post 'auth_codes' do
      mobile = params[:mobile]
      auth_code_type = params[:auth_code_type]
      auth_code = AuthCode.new(
        mobile: mobile,
        auth_code_type: auth_code_type,
        auth_state: false,
        code: AuthCode.generate_code,
        expire_at: Time.now + 10.minutes
      )
      AuthCode.deactivate_old_auth_code(mobile, auth_code_type)
      if auth_code_type == 'sign_up' && User.exists?(mobile: mobile)
        bad_request!('手机号已注册')
      elsif auth_code_type == 'forget_password' && !User.exists?(mobile: mobile)
        bad_request!('手机号未注册')
      else
        if SmsHelper.send_auth_code_sms mobile, auth_code.code, auth_code_type
          auth_code.sent_at = Time.now
          auth_code.save!
          {message: '验证码发送成功'}
        else
          render_api_error!('短信发送失败', 503)
        end
      end
    end
  end
end
