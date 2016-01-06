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
    update_grab_numbers > 0
  end

  def update_grab_numbers
    valid_grab_numbers = self.grab_numbers.to_i + (Time.now.to_i - self.first_grab_time.to_i)/3600
    valid_grab_numbers = valid_grab_numbers > ENV["GRAB_TIME_LIMIT"].to_i ? ENV["GRAB_TIME_LIMIT"].to_i : valid_grab_numbers
    self.update_attributes(grab_numbers: valid_grab_numbers) unless valid_grab_numbers == self.grab_numbers
    valid_grab_numbers
  end

  def is_coupon_out_of_limit? coupon
    coupon.perlimit > self.coupon_items.un_used.where(coupon_id: coupon.id).count
  end

  def save_coupon_item_redundancy coupon
    self.coupon_items.create(coupon_id: coupon.id, coupon_sn: SecureRandom.uuid, state: 0,
                             expired_at: coupon.end_time, shop_id: coupon.shop_id,
                             shop_name: coupon.shop.name, coupon_name: coupon.name, coupon_type: coupon.cc_type,
                             coupon_cheap: coupon.cheap, coupon_discount: coupon.discount,
                             coupon_start_time: coupon.start_time, coupon_end_time: coupon.end_time,
                             coupon_min_amount: coupon.min_amount)
  end

  def get_valid_shake_grab_coupon coupons
    if coupons.present?
      coupon = coupons[rand(coupons.size)]
      if self.is_coupon_out_of_limit?(coupon) && coupon.is_valid_coupon_left? && (Time.now < coupon.end_time)
        coupon
      end
    else
      false
    end
  end

  def update_after_shake_grab
    if self.grab_numbers == ENV["GRAB_TIME_LIMIT"].to_i
      self.update_attributes(grab_numbers: self.grab_numbers - 1, first_grab_time: Time.now)
    else
      self.update_attributes(grab_numbers: self.grab_numbers - 1)
    end
  end
end
