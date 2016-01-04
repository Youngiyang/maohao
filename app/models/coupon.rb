class Coupon < ActiveRecord::Base
  belongs_to :shop
  has_many :coupon_items

  def is_coupon_grab_time?
    binding.pry
    start_time_valid = self.start_time.present? ? (Time.now > self.start_time) : true
    end_time_valid = self.end_time.present? ? (Time.now > self.end_time) : true
    start_time_valid && end_time_valid
  end

  def is_valid_coupon_left?
    self.total - self.giveout > 0
  end

end
