class AuthCode < ActiveRecord::Base

  VALID_MOBILE_REGEX = /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}\z/
  validates :mobile, presence: true, format: { with: VALID_MOBILE_REGEX }
  validates :code, presence: true
  validates :auth_code_type, inclusion: {in: %w(sign_up forget_password)}

  def self.generate_code
    ((0...9).to_a.sample(3) + (0...9).to_a.sample(3)).join()
  end

  def activated?
    !auth_state && Time.now < expire_at
  end

  def send_frequently?
    sent_at < 1.minutes.ago
  end
end
