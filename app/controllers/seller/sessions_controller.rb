class Seller::SessionsController < ApplicationController
  layout 'pages'
  skip_before_action :authenticated!, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(mobile: params[:session][:mobile])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
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
    redirect_to seller_login_path
    puts "tuichuchenggggg"
    flash.now[:success] = "安全退出成功！"
  end
end
