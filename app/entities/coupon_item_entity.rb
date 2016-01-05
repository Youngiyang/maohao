class CouponItemEntity < Grape::Entity
  root 'user_coupons'

  format_with(:utc_time) { |t| t.to_i }

  expose :id, :coupon_id, :coupon_sn, :state, :used_at, :shop_id, :shop_name,
         :coupon_name, :coupon_type, :coupon_cheap, :coupon_discount,
         :coupon_min_amount, :coupon_image

  with_options(format_with: :utc_time) do
    expose :expired_at, :coupon_start_time, :coupon_end_time, :created_at
  end

  expose :expired do |obj|
    obj.coupon_end_time < Time.now
  end

  expose :evaluated do |object|
    object.try(:evaluation_id).present?
  end
end
