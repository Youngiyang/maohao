class V1::AuthCodesController < V1::BaseController
  def create
    auth_code = AuthCode.find_or_initialize_by(mobile: params[:mobile])
    auth_code.auth_state = false
    if auth_code.save
      if auth_code.send_by_sms
        render json: api_return(true, '000', message: '验证码发送成功')
      else
        render json: api_return(false,'100002')
      end
    else
      puts auth_code.errors.inspect
      render json: api_return(false, '100001')
    end
  end
end
