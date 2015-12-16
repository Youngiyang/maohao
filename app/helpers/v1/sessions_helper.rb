module V1::SessionsHelper
  # def authenticated_by_token!
  #   status, code, return_hash = false, "000", {}
  #   binding.pry
  #   if current_user
  #     unless current_user.state == 1
  #       code = "101002"
  #       render json: api_return(status, code, return_hash)
  #     end
  #   else
  #     code = "101005"
  #     render json: api_return(status, code, return_hash)
  #   end
  # end

  # def current_user
  #   token = ActionController::HttpAuthentication::Token.token_and_options(request)[0]
  #   token = token.present? ? token : params[:user_token]
  #   @current_user ||= User.find_by(auth_token: token)
  # end
end
