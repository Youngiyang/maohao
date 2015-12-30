class ShopDetailEntity < Grape::Entity
  root 'shops'
  format_with(:business_hour_time) {|t| t.strftime('%H:%M')}

  expose :id, :name, :logo, :images, :lnt, :lng, :address, :telephone,
         :business_on_holiday, :star_grade, :is_recommand, :description,
         :notice, :created_at

  expose :first_class, :second_class, using: ShopClassEntity
  expose :distance, safe: true

  expose :is_followed do |shop_obj, options|
    options[:user] && options[:user].collections.exists?(object: shop_obj)
  end

  with_options(format_with: :business_hour_time) do
    expose :business_hour_start, :business_hour_end
  end
end
