class CouponDetailEntity < BaseEntity
  root 'coupons'

  expose :id, :name, :remark, :cc_type, :cheap, :discount,
         :min_amount, :perlimit, :period_time, :total, :giveout

  expose_timestamp :start_grab_time, :end_grab_time, :start_time, :end_time

  expose_qiniu_url :image
end
