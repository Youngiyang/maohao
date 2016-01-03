class User < ActiveRecord::Base
  has_many :coupon_items
  has_many :coupons, through: :coupon_items
  has_many :collections
  has_many :collection_shops, through: :collections,
           source: :object, source_type: 'Shop'
  has_many :shops

  scope :sellers, ->{where(is_seller: true)}

  has_secure_password validations: false

  before_create :ensure_auth_token!

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true, allow_blank: true
  VALID_MOBILE_REGEX = /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}\z/
  validates :mobile, presence: true, format: { with: VALID_MOBILE_REGEX }, uniqueness: true
  validates :password, presence: true, length: 6..18, if: Proc.new {|user| user.new_record? || user.password_digest_changed?}
  validates :sex, inclusion: { in: ['male', 'female', 'secret'] }, allow_blank: true
  validates :state, presence: true, inclusion: { in: [0, 1] }

  def reset_auth_token
    self.auth_token = SecureRandom.uuid
  end

  def ensure_auth_token!
    unless self.auth_token.present?
      self.reset_auth_token
    end
  end

  def grab_valid?
    
  end

end
