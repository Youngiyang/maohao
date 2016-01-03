class Shop < ActiveRecord::Base
  include Concerns::GeoCoordinate

  has_many :coupons
  has_many :active_coupons, -> {where('state = 1 and end_grab_time > ?', Time.now)}, class_name: 'Coupon'
  has_many :deactive_coupons, -> {where('state = 1 and end_grab_time < ?', Time.now)}, class_name: 'Coupon'
  belongs_to :first_class, class_name: 'ShopClass'
  belongs_to :second_class, class_name: 'ShopClass'
  belongs_to :city, class_name: 'Region'
  belongs_to :user
  has_many :collections, as: :object

  validates :name, presence: true, length: 1..16
  validates :address, presence: true, length: 1..50
  VALID_TEL_REGEX = /\A(\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))\z/
  validates :telephone, presence: true, format: { with: VALID_TEL_REGEX }
  validates :description, length: { maximum: 200 }
  validates :notice, length: { maximum: 200 }
  validates :audit_reason, length: { maximum: 200 }

  def self.get_shops_by_location lnt, lng, distance
    position = "point(#{lnt} #{lng})"
    self.where("st_dwithin(location, '#{position}', #{distance})")
    # all
  end
end
