class Shop < ActiveRecord::Base
  include Concerns::GeoCoordinate

  has_many :coupons
  has_many :active_coupons, -> {where('state = 1 and end_time > ?', Time.now)}, class_name: 'Coupon'
  has_many :deactive_coupons, -> {where('state = 1 and end_time < ?', Time.now)}, class_name: 'Coupon'
  belongs_to :first_class, class_name: 'ShopClass'
  belongs_to :second_class, class_name: 'ShopClass'
  belongs_to :city, class_name: 'Region'
  belongs_to :user, counter_cache: true
  has_many :collections, as: :object

  validates :name, presence: true, length: 1..16
  validates :address, presence: true, length: 1..50
  VALID_TEL_REGEX = /\A(\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))\z/
  validates :telephone, presence: true, format: { with: VALID_TEL_REGEX }
  validates :description, length: { maximum: 200 }
  validates :notice, length: { maximum: 200 }
  validates :audit_reason, length: { maximum: 200 }

  default_scope {where(state: 1)}
  scope :with_city_id, ->(city_id) {where(city_id: city_id)}
  scope :with_class, ->{includes(:first_class, :second_class)}

  def self.get_shops_by_location lng, lat, distance
    position = "point(#{lng} #{lat})"
    self.where("st_dwithin(location::geography, ?::geography, ?)", position, distance)
    # all
  end

  def self.with_distance lng, lat, distance_name='distance'
    position = "point(#{lng} #{lat})"
    self.select("shops.*, st_distance(location::geography, '#{position}'::geography) as #{distance_name}")
  end

  def self.random_shops
    self.select("shops.*, random() as rnd").order("rnd")
  end
end
