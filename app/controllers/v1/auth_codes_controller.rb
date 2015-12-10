class V1::AuthCodesController < V1::BaseController
  def create
    status, code = false, '000'

    auth_code = AuthCode.find_or_initialize_by(mobile: params[:mobile])

    #TODO, auth_state is defaultly as false and if you want to use callbacks why not do this in it.
    auth_code.auth_state = false
    
    if auth_code.save
      #TODO, I changed this sms method to a helper, the sms method should not be a model method or belongs to any model.
      if SmsHelper.send_auth_code_sms params[:mobile], auth_code.code
        status = true
      else
        code = '100002'
      end
    else
      #TODO, if this save failed, you can not say that's just the cellphone number error.
      code = '100001'
    end

    render json: api_return(status, code)
  end
end
