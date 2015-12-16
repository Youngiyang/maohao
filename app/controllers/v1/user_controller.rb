class V1::UserController < V1::BaseController
  before_action :authenticated_by_token!

  def reset_password
    status, code, return_hash = false, "000", {}
    old_password = params[:old_password]
    new_password = params[:new_password]
    new_password_confirmation = params[:new_password_confirmation]
    if new_password.present? && new_password_confirmation.present? && old_password.present?
      if current_user.authenticate(old_password)
        if new_password == new_password_confirmation
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
          # 确认密码与新密码不一致
          code = "103001"
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
end
