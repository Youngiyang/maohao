class AuthCode < ActiveRecord::Base

  VALID_MOBILE_REGEX = /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}\z/
  validates :mobile, presence: true, format: { with: VALID_MOBILE_REGEX }
  validates :code, presence: true
  validates :auth_code_type, inclusion: {in: %w(sign_up forget_password)}

  def self.generate_code
    ((0...9).to_a.sample(3) + (0...9).to_a.sample(3)).join()
  end

  def self.valid_auth_code?(mobile, auth_code_type, code)
    target_auth_code = where(mobile: mobile, auth_code_type: auth_code_type, auth_state: false).last
    valid = false
    if target_auth_code && target_auth_code.activated?
      target_auth_code.update_attribute(:auth_state, true)
      if target_auth_code.code == code
        valid = true
      end
    end
    valid
  end

  def self.deactivate_old_auth_code(mobile, auth_code_type)
    where(mobile: mobile, auth_code_type: auth_code_type, auth_state: false).update_all(auth_state: true)
  end

  def activated?
    !auth_state && Time.now < expire_at
  end

  def send_frequently?
    sent_at < 1.minutes.ago
  end
end
