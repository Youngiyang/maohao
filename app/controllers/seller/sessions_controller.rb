class Seller::SessionsController < Seller::BaseController
  layout 'seller/pages'
  include ApplicationHelper
  skip_before_action :authenticated!, only: [:new, :create, :upload]
  def new
  end

  def upload
    # 获取上传凭证
    @uptoken = uptoken
  end

  def create
    user = User.find_by(mobile: params[:session][:mobile])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = "登录成功！"
      redirect_to seller_user_path(user)
    else
      flash.now[:danger] = "用户名或者密码错误"
      render 'new'

    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "安全退出成功！"
    redirect_to seller_login_path
  end

end
