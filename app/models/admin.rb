class Admin < ActiveRecord::Base
  attr_accessor :remember_token
  has_secure_password
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: false }

  def Admin.digest(string)   #返回指定字符的哈希摘要
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def Admin.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = Admin.new_token
    update_attribute(:remember_digest, Admin.digest(remember_token))
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
