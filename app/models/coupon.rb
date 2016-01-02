class Coupon < ActiveRecord::Base
  belongs_to :shop
  has_many :coupon_items

  def is_coupon_grab_time?
    Time.now > start_grab_time && Time.now < end_grab_time
  end

end
