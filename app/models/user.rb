class User < ActiveRecord::Base
  has_many :coupon_items
  has_many :collections
  has_many :shops

  has_secure_password validations: false

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true, allow_blank: true
  VALID_MOBILE_REGEX = /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}\z/
  validates :mobile, presence: true, format: { with: VALID_MOBILE_REGEX }, uniqueness: true
  validates :password, presence: true, length: 6..18
  validates :sex, inclusion: { in: ['male', 'female', 'secret'] }, allow_blank: true
  validates :state, presence: true, inclusion: { in: [0, 1] }
end
