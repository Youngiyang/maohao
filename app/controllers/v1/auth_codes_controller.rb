class V1::AuthCodesController < V1::BaseController
  def create
    status, code = false, '100000'

    auth_code = AuthCode.new(mobile: params[:mobile])

    if auth_code.save
      if SmsHelper.send_auth_code_sms params[:mobile], auth_code.code
        auth_code.update_attribute(:sent_at, Time.now)
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
