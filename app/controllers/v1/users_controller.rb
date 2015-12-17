class V1::UsersController < V1::BaseController
  before_action :authenticated_by_token!, only: [:reset_password, :qiniu_upload]

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

  def forget_password
    status, code, return_hash = false, '000', {}
    if params[:mobile].present? && params[:password].present? && params[:auth_code].present?
      user = User.find_by(mobile: params[:mobile])
      if user.nil?
        # 未注册
        code = 102005
      elsif AuthCode.valid_auth_code?(params[:mobile], 'forget_password', params[:auth_code])
        user.reset_auth_token
        user.password = params[:password]
        if user.save
          status = true
          return_hash[:message] = '密码修改成功'
        else
          # 密码不符合要求
          code = 102002
          return_hash[:errors] = user.errors
        end
      else
        # 验证码错误
        code = 102003
      end
    else
      # 参数缺失
      code = 102004
    end

    render json: api_return(status, code, return_hash)
  end

  def reset_password
    status, code, return_hash = false, "000", {}
    if params[:old_password].present? && params[:new_password].present?
      old_password = params[:old_password]
      new_password = params[:new_password]
      if current_user.authenticate(old_password)
        if new_password != old_password
          current_user.password = new_password
          current_user.reset_auth_token
          if current_user.save
            status = true
            return_hash[:message] = "密码已修改"
            return_hash[:auth_token] = current_user.auth_token
          else
            # 新密码格式有误
            code = "103003"
            return_hash[:errors] = current_user.errors
          end
        else
          # 新密码与原密码一样
          code = "103005"
        end
      else
        # 原密码错误
        code = "103002"
      end
    else
      # 参数错误
      code = "103004"
    end
    render json: api_return(status, code, return_hash)
  end

  def qiniu_uptoken
    status, code, return_hash = true, "000", {}
    return_hash[:qiniu_uptoken] = uptoken
    return_hash[:qiniu_domain] = Rails.application.config.qiniu_domain
    render json: api_return(status, code, return_hash)
  end
end
