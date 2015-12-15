module V1::SessionsHelper


  def authenticated!
    status, code, return_hash = false, "000", {}
    if current_user
      unless current_user.state == 1
        code = "101002"
        render json: api_return(status, code, return_hash)
      end
    else
      code = "101005"
      render json: api_return(status, code, return_hash)
    end
  end

  def current_user
    if ActionController::HttpAuthentication::Token.token_and_options(request)
      token = ActionController::HttpAuthentication::Token.token_and_options(request)[0]
    else
      token = params[:private_token]
    end
    if token
      @current_user ||= User.find_by(auth_token: token)
    end
  end
end
