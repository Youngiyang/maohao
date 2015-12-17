class Admin::PasswordController < Admin::BaseController
  layout 'admin/pages'
  def new
  end

  def reset_from_web
    @admin = current_admin
    old_password = params[:password][:old_password]
    new_password = params[:password][:new_password]
    new_password_confirm = params[:password][:new_password_confirm]
    if old_password.present? && new_password.present? && new_password_confirm.present?
      if @admin && @admin.authenticate(old_password)
        if new_password == new_password_confirm
          @admin.update_columns(password_digest: Admin.digest(new_password))
          puts "密码修改成功"
          redirect_to admin_login_path
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
end
