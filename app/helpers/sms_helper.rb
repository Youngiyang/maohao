module SmsHelper
  def self.send_auth_code_sms number, code
    content = "【茂号网】验证码：#{code}，此验证码10分钟内有效。非本人操作，请忽略"
    url = "http://106.3.37.99:7799/sms.aspx?action=send&userid=668&account=mt&password=123456&mobile=#{number}&content=#{content}"
    uri = URI.parse(URI.encode(url.strip))
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = true
    end
    request = Net::HTTP::Post.new(uri.request_uri)
    # request['Content-Type'] = 'application/json;charset=utf-8'
    # request['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1; rv:29.0) Gecko/20100101 Firefox/29.0'
    # request['X-ACL-TOKEN'] = 'xxx_token'
    # request.set_form_data(params)
    # request.body = params.to_json
    begin
      response = http.start { |http| http.request(request) }
      response.is_a?(Net::HTTPSuccess)
    rescue Net::HTTPExceptions
      false
    end
    true
  end
end