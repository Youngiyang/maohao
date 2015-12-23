class CouponEntity < Grape::Entity
  root 'coupons'

  expose :id, :shop_id, :name, :remark, :cc_type, :start_grab_time, :end_grab_time,
         :start_time, :end_time, :period_time, :cheap, :min_amount, :total, :giveout,
         :perlimit, :created_at, :updated_at
end
