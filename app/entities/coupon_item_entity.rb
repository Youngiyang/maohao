class CouponItemEntity < BaseEntity
  root 'user_coupons'

  expose :id, :coupon_id, :coupon_sn, :state, :used_at, :shop_id, :shop_name,
         :coupon_name, :coupon_type, :coupon_cheap, :coupon_discount,
         :coupon_min_amount
  expose_qiniu_url :coupon_image

  expose_timestamp :expired_at, :coupon_start_time, :coupon_end_time, :created_at

  expose :expired do |obj|
    obj.coupon_end_time < Time.now
  end

  expose :evaluated do |object|
    object.try(:evaluation_id).present?
  end
end
