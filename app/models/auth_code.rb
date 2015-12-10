class AuthCode < ActiveRecord::Base
  VALID_MOBILE_REGEX = /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}\z/
  validates :mobile, presence: true, format: { with: VALID_MOBILE_REGEX }, uniqueness: true
  validates :code, presence: true

  before_save :set_code

  def self.generate_code
    ((0...9).to_a.sample(3) + (0...9).to_a.sample(3)).join()
  end

  def activated?
    !auth_state && Time.now > expire_at
  end

  def send_frequently?
    sent_at < 1.minutes.ago
  end

  def send_by_sms
    content = "【茂号网】验证码：#{code}，此验证码10分钟内有效。非本人操作，请忽略"
    url = "http://106.3.37.99:7799/sms.aspx?action=send&userid=668&account=mt&password=123456&mobile=#{mobile}&content=#{content}"
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

  private
    def set_code
      unless auth_state
        self.code = AuthCode.generate_code
        self.sent_at = Time.now
        self.expire_at = Time.now + 10.minutes
      end
    end
end
