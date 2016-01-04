class ShopDetailEntity < Grape::Entity
  root 'shops'

  expose :id, :name, :logo, :images, :lnt, :lng, :address, :telephone,
         :business_on_holiday, :star_grade, :is_recommand, :description,
         :notice, :created_at

  expose :first_class, :second_class, using: ShopClassEntity
  expose :distance, safe: true

  expose :is_followed do |shop_obj, options|
    options[:user] && options[:user].collections.exists?(object: shop_obj)
  end
end
