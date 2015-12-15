class V1::UsersController < V1::BaseController
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
    binding.pry
    status, code, return_hash = false, '000', {}
    if params[:mobile].present? && params[:password].present?
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
end
