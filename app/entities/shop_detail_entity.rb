class ShopDetailEntity < Grape::Entity
  root 'shops'

  expose :id, :name, :logo, :images, :lnt, :lng, :address, :telephone,
         :business_on_holiday, :star_grade, :is_recommand, :description,
         :notice, :business_hour_start, :business_hour_end

  expose :first_class, :second_class, using: ShopClassEntity

  expose :is_followed do |shop_obj, options|
    options[:user] && options[:user].collections.exists?(object: shop_obj)
  end
end
