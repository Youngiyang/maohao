class Admin::SessionsController < ApplicationController
  layout 'pages'
  skip_before_action :authenticated!, only: [:new, :create]
  def new
  end

  def create
    admin = Admin.where("name = :login_name or email = :login_name", {login_name: params[:session][:login_name]}).first
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      flash.now[:success] = "登录成功！"
      puts "登录成功！"
      redirect_to root_path
    else
      puts "用户名或者密码错误"
      render 'new'
      flash.now[:danger] = "用户名或者密码错误"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to admin_login_path
    puts "退出成功"
    flash.now[:success] = "安全退出成功！"
  end
end
