class V1::UsersController < V1::BaseController
  def create
    status, code, return_hash = false, "000", {}
    if User.exists?(mobile: params[:mobile])
      code = 102001
    else
      if AuthCode.valid_auth_code?(params[:mobile], 'sign_up', params[:auth_code])
        user = User.new(
          mobile: params[:mobile],
          password: params[:password]
          auth_token: SecureRandom.uuid
        )
        if user.save
          status = true
          return_hash[:message] = '注册成功'
        else
          code = 102002
        end
      else
        code = 102003
      end
    end

    render json: api_return(status, code, return_hash)
  end
end
