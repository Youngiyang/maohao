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
          puts "密码修改成功"
          redirect_to seller_login_path
        else
          puts "两次输入密码不一致"
          render 'new'
        end
      else
        puts "旧密码错误"
        render 'new'
      end
    end
  end

  def reset_from_mobile
    mobile =  params[:password][:mobile]
    @user = User.find_by(mobile: mobile)
    auth_code = params[:password][:auth_code]
    new_password = params[:password][:new_password]
    if mobile.present? && auth_code.present? && new_password.present?
      if auth_code == session[:auth_code]["code"]
         if Time.now < session[:auth_code]["expire_at"]
            @user.update_columns(password_digest: User.digest(new_password))
            puts "密码修改成功"
            session[:auth_code] = nil
            redirect_to seller_login_path
         else
          session[:auth_code] = nil
          puts "验证码已过期"
         end
      else
        session[:auth_code] = nil
        puts "验证码错误"
      end
    else
      puts "不能有空的输入框"
    end
  end

end
