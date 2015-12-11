class V1::AuthCodesController < V1::BaseController
  def create
    status, code, return_hash = false, '000', {}

    auth_code_type = params[:auth_code_type]

    auth_code = AuthCode.new(
      mobile: params[:mobile],
      auth_code_type: auth_code_type,
      auth_state: false,
      code: AuthCode.generate_code,
      expire_at: Time.now + 10.minutes
    )

    # 把相同手机号码且相同类型的作废
    if auth_code.valid?
      AuthCode.where(mobile: params[:mobile], auth_code_type: auth_code_type, auth_state: false).update_all(auth_state: true)
    end

    if auth_code.save
      if SmsHelper.send_auth_code_sms params[:mobile], auth_code.code, auth_code_type
        auth_code.update_attributes(sent_at: Time.now)
        status = true
        return_hash[:message] = '手机验证码发送成功'
      else
        code = '100002'
      end
    else
      if auth_code.errors.include?(:mobile)
        code = '100001'
      elsif auth_code.errors.include?(:auth_code_type)
        code = '100004'
      else
        code = '100003'
      end
    end

    render json: api_return(status, code, return_hash)
  end
end
