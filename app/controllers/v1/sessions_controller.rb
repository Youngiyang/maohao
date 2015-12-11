class V1::SessionsController < V1::BaseController
  def create
    status, code, return_hash = true, "000", {}
    @user = User.find_by(mobile: session_params[:mobile])
    if @user.state == 1
      if @user && @user.authenticate(session_params[:password])
        return_hash[:auth_token] = @user.auth_token
        # return_hash[:user_link] = v1_user_url(@user)
      else
        status = false
        code = "101001"
      end
    else
      status = false
      code = "101002"
    end
      render json: api_return(status, code, return_hash)
  end

  def session_params
    params.require(:session).permit(:mobile, :password)
  end
end
