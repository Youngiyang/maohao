class V1::SessionsController < V1::BaseController
  def create
    status, code, return_hash = false, "000", {}
    @user = User.find_by(mobile: params[:mobile])
    if @user
      if @user.authenticate(params[:password])
        if @user.state == 1
          status = true
          return_hash[:auth_token] = @user.auth_token
        else
          code = "101002"
        end
      else
        code = "101001"
      end
    else
      code = "101003"
    end
    render json: api_return(status, code, return_hash)
  end
end
