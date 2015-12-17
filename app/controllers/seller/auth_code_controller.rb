class Seller::AuthCodeController < Seller::BaseController
  skip_before_action :authenticated!
  def send_code
    mobile = params[:mobile]
    user = User.find_by(mobile: params[:mobile])
    if user.present?
      auth_code = { code: generate_code, expire_at: Time.now + 2.minutes, auth_state: false }
      if SmsHelper.send_auth_code_sms mobile, auth_code[:code]
        session[:auth_code] = auth_code
        render js: "alert(#{session[:auth_code][:code]})"
      else
        render js: "alert('手机发送验证码失败')"
      end
    else
      puts "该用户不存在"
      render js: "alert('发送验证码失败')"
    end
  end

  private
    def generate_code
      ((0...9).to_a.sample(3) + (0...9).to_a.sample(3)).join()
    end
end




