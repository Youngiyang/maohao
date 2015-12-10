class V1::AuthCodesController < V1::BaseController
  def create
    status, code = false, '100000'

    auth_code = AuthCode.new(mobile: params[:mobile], auth_state: false)

    binding.pry
    if auth_code.save
      auth_code_type = 'sign_up'
      if SmsHelper.send_auth_code_sms params[:mobile], auth_code.code, auth_code_type
        auth_code.update_attributes(sent_at: Time.now, auth_code_type: auth_code_type)
        status = true
      else
        code = '100002'
      end
    else
      if auth_code.errors.include?(:mobile)
        code = '100001'
      else
        code = '100003'
      end
    end

    render json: api_return(status, code)
  end
end
