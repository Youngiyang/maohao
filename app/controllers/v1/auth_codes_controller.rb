class V1::AuthCodesController < V1::BaseController
  def create
    status, code, return_hash = false, '000', {}
    auth_code_type = params[:auth_code_type]

    if params[:mobile].present? && params[:auth_code_type].present?
      auth_code = AuthCode.new(
        mobile: params[:mobile],
        auth_code_type: auth_code_type,
        auth_state: false,
        code: AuthCode.generate_code,
        expire_at: Time.now + 10.minutes
      )

      if auth_code.valid?
        # 把相同手机号码且相同类型的作废
        AuthCode.deactivate_old_auth_code(params[:mobile], params[:auth_code_type])
        result =  check_auth_type_for_mobile(params[:mobile], params[:auth_code_type])
        if result.nil?
          auth_code.save(validate: false)
          if SmsHelper.send_auth_code_sms params[:mobile], auth_code.code, auth_code_type
            auth_code.update_attribute(:sent_at, Time.now)
            status = true
            return_hash[:message] = '手机验证码发送成功'
          else
            code = '100002'
          end
        else
          code = result
        end
      else
        code = '100003'
        return_hash[:errors] = auth_code.errors
      end
    else
      code = '100001'
    end
    render json: api_return(status, code, return_hash)
  end

  private
    def check_auth_type_for_mobile(mobile, auth_code_type)
      if auth_code_type == 'sign_up'
        if User.exists?(mobile: mobile)
          '100004'
        end
      elsif auth_code_type == 'forget_password'
        unless User.exists?(mobile: mobile)
          '100005'
        end
      end
    end
end
