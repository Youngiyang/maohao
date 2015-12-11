class User < ActiveRecord::Base
  has_many :coupon_items
  has_many :collections
  has_many :shops

  has_secure_password
end
