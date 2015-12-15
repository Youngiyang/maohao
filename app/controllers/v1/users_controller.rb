class V1::UsersController < V1::BaseController
  before_action :authenticated!, only: [:reset_password]

  def create
    status, code, return_hash = false, "000", {}
    if params[:mobile].present? && params[:password].present?
      if User.exists?(mobile: params[:mobile])
        code = 102001
      else
        if AuthCode.valid_auth_code?(params[:mobile], 'sign_up', params[:auth_code])
          user = User.new(
            mobile: params[:mobile],
            password: params[:password],
            auth_token: SecureRandom.uuid
          )
          if user.save
            status = true
            return_hash[:message] = '注册成功'
          else
            # 参数校验错误
            code = 102002
          end
        else
          # 验证码错误
          code = 102003
        end
      end
    else
      code = 102004
    end

    render json: api_return(status, code, return_hash)
  end

  def reset_password
    status, code, return_hash = false, "000", {}
    old_password = params[:old_password]
    new_password = params[:new_password]
    new_password_confirmation = params[:new_password_confirmation]
    if new_password.present? && new_password_confirmation.present? && old_password.present?
      if current_user.authenticate(old_password)
        if new_password == new_password_confirmation
          current_user.password = new_password
          if current_user.save
            current_user.reset_auth_token
            status = true
            return_hash[:message] = "密码已修改"
            return_hash[:auth_token] = current_user.auth_token
          else
            # 新密码格式有误
            code = "102008"
            return_hash[:errors] = current_user.errors
          end
        else
          # 确认密码与新密码不一致
          code = "102006"
        end
      else
        # 原密码错误
        code = "102007"
      end
    else
      code = "102009"
    end
    render json: api_return(status, code, return_hash)
  end
end
