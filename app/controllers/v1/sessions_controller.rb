class V1::SessionsController < V1::BaseController
  def create
    status, code, return_hash = false, "000", {}
    @user = User.find_by(mobile: params[:mobile])
    if @user.state == 1
      if @user && @user.authenticate(params[:password])
        status = true
        return_hash[:auth_token] = @user.auth_token
        # return_hash[:user_link] = v1_user_url(@user)
      else
        code = "101001"
      end
    else
      code = "101002"
    end
      render json: api_return(status, code, return_hash)
  end
end
