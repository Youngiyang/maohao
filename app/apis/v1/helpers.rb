module V1
  module Helpers
    AUTH_TOKEN_HEADER = 'HTTP_AUTH_TOKEN'
    AUTH_TOKEN_PARAM = :auth_token

    def current_user
      private_token = (params[AUTH_TOKEN_PARAM] || env[AUTH_TOKEN_HEADER]).to_s
      @current_user ||= User.find_by(auth_token: private_token)
    end

    def authenticate_by_token!
      unauthorized! unless current_user
    end

    def attributes_for_keys(keys, custom_params = nil)
      attrs = {}
      keys.each do |key|
        if params[key].present? or (params.has_key?(key) and params[key] == false)
          attrs[key] = params[key]
        end
      end
      ActionController::Parameters.new(attrs).permit!
    end

    def qiniu_uptoken
      put_policy = Qiniu::Auth::PutPolicy.new(
        "playmall"     # 存储空间
        # key,        # 最终资源名，可省略，即缺省为“创建”语义
        # expires_in, # 相对有效期，可省略，缺省为3600秒后 uptoken 过期
        # deadline    # 绝对有效期，可省略，指明 uptoken 过期期限（绝对值），通常用于调试
      )
      uptoken = Qiniu::Auth.generate_uptoken(put_policy)
    end


    # api error helpers

    def unauthorized!
      render_api_error!('Unauthorized', 401)
    end

    def forbidden!(reason = nil)
      message = ['Forbidden']
      message << " - #{reason}" if reason
      render_api_error!(message.join(' '), 403)
    end

    def bad_request!(reason=nil, options={})
      message  = reason.present? ? reason : "Bad Request"
      render_api_error!(message, 400, options)
    end

    def not_found!(resource = nil)
      message = []
      message << resource if resource
      message << "Not Found"
      render_api_error!(message.join(' '), 404)
    end

    def render_validation_error!(resource)
      if resource.errors.any?
        render_api_error!(resource.errors.messages, 400)
      end
    end

    def render_api_error!(message, status, options={})
      error!({code: status, message: message}.merge!(options), status)
    end
  end
end
