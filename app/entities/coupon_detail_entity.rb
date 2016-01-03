class CouponDetailEntity < Grape::Entity
  root 'coupons'

  format_with(:utc_time) { |t| t.to_i }

  expose :id, :name, :remark, :cc_type, :cheap, :discount,
         :min_amount, :perlimit, :period_time, :total, :giveout, :image

  with_options(format_with: :utc_time) do
    expose :start_grab_time, :end_grab_time, :start_time, :end_time
  end
end
