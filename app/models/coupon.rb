class Coupon < ActiveRecord::Base
  belongs_to :shop
  has_many :coupon_items
end
