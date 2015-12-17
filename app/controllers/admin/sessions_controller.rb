class Admin::SessionsController < Admin::BaseController
  layout 'admin/pages'
  skip_before_action :authenticated!, only: [:new, :create]
  def new
  end

  def create
    admin = Admin.where("name = :login_name or email = :login_name", {login_name: params[:session][:login_name]}).first
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      params[:session][:remember_me] == '1' ? remember(admin) : forget(admin)
      flash[:success] = "登录成功！"
      redirect_to admin_admin_path(admin)
    else
      flash.now[:danger] = "用户名或者密码错误"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash.now[:success] = "安全退出成功！"
    redirect_to admin_login_path

  end
end
