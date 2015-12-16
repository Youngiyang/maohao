module V1::SessionsHelper


  def authenticated_by_token!
    status, code, return_hash = false, "000", {}
    if params[:auth_token].present?
      if current_user
        unless current_user.state == 1
          # 账号已被禁用
          code = "101002"
          render json: api_return(status, code, return_hash)
        end
      else
        # 不存在与authen_token匹配的用户
        code = "101005"
        render json: api_return(status, code, return_hash)
      end
    else
      # 参数缺失
      code = "103004"
      render json: api_return(status, code, return_hash)
    end
  end

  def current_user
    @current_user ||= User.find_by(auth_token: params[:auth_token])
  end
end
