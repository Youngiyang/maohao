class AuthCode < ActiveRecord::Base

  # TODO, the reg is not rightfully worked, try a cellphone number on it. 
  VALID_MOBILE_REGEX = /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}\z/
  validates :mobile, presence: true, format: { with: VALID_MOBILE_REGEX }, uniqueness: true
  validates :code, presence: true

  # TODO, before_save is called after the validates, so you will never insert one record when you create an new one,
  #       though you will successflly update. if you want to use callbacks, try before_validation.
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

  private
    def set_code
      unless auth_state
        self.code = AuthCode.generate_code
        self.sent_at = Time.now
        self.expire_at = Time.now + 10.minutes
      end
    end
end
