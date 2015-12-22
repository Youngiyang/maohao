class ShopEntity < Grape::Entity
  root 'shops'
  format_with(:business_hour_time) {|t| t.strftime('%H:%M')}

  expose :id, :name, :logo, :images, :lnt, :lng, :telephone, :business_on_holiday,
         :star_grade, :is_recommand, :description, :notice, :created_at
  with_options(format_with: :business_hour_time) do
    expose :business_hour_start, :business_hour_end
  end

  expose :active_coupons, with: AddonCouponEntity, as: :coupons

end
