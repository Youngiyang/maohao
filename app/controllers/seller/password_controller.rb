class Seller::PasswordController < Seller::BaseController
  layout 'seller/pages'
  skip_before_action :authenticated!, only: [:forget, :reset_from_mobile]
  def new
  end

  def forget
  end

  def reset_from_web
    @user = current_user
    old_password = params[:password][:old_password]
    new_password = params[:password][:new_password]
    new_password_confirm = params[:password][:new_password_confirm]
    if old_password.present? && new_password.present? && new_password_confirm.present?
      if @user && @user.authenticate(old_password)
        if new_password == new_password_confirm
          @user.update_columns(password_digest: User.digest(new_password))
          redirect_to seller_login_path
          flash[:success] = "密码修改成功"
        else
          flash.now[:danger] = "两次输入密码不一致"
          render 'new'
        end
      else
        flash.now[:danger] = "旧密码错误"
        render 'new'
      end
    end
  end

  def reset_from_mobile
    mobile =  params[:password][:mobile]
    @user = User.find_by(mobile: mobile)
    auth_code = params[:password][:auth_code]
    new_password = params[:password][:new_password]
    new_password_confirm = params[:password][:new_password_confirm]
    if mobile.present? && auth_code.present? && new_password.present?
      if auth_code == session[:auth_code]["code"]
        if Time.now < session[:auth_code]["expire_at"]
          if new_password == new_password_confirm
            @user.update_columns(password_digest: User.digest(new_password))
            session[:auth_code] = nil
            flash[:success] = "密码修改成功"
            redirect_to seller_login_path
          else
            flash[:danger] = "两次密码输入不一样"
            render 'forget'
          end
        else
          session[:auth_code] = nil
          flash[:danger] = "验证码已过期"
          render 'forget'
        end
      else
        session[:auth_code] = nil
        flash[:danger] = "验证码错误"
        render 'forget'
      end
    else
      flash[:danger] = "不能有空的输入框"
      render 'forget'
    end
  end

end
