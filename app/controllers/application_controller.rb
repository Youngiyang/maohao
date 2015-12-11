class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def api_return status, code, hash={}
    return_hash = {}
    return_hash[:code] = code
    return_hash[:message] = 'success'
    return_hash.merge! hash
    if status
      return_hash.to_json
    else
      return_error_json code
    end
  end

  def return_error_json code
    return_hash = {}
    message = I18n.t code, scope: 'error'
    if message.include?('translation missing')
      # error code not defined
      return_hash[:code] = '101'
      return_hash[:message] = "未定义错误代号：#{code}"
    else
      return_hash[:code] = code
      return_hash[:message] = message
    end
    return_hash
  end
end
