class User < ActiveRecord::Base
  attr_accessor :remember_token
  has_many :coupon_items
  has_many :collections
  has_many :shops

  has_secure_password
  before_save :downcase_email
  VALID_MOBILE_REGEX = /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}\z/
  validates :mobile, presence: true, format: { with: VALID_MOBILE_REGEX }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: false }

  def User.digest(string)   #返回指定字符的哈希摘要
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenicated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

 def forget
    update_attribute(:remember_digest, nil)
  end

  private
    def downcase_email
      if !self.email.blank?
        self.email = email.downcase
      end
    end
end
