class ShopDetailEntity < BaseEntity
  root 'shops'

  expose :id, :name, :lat, :lng, :address, :telephone,
         :business_on_holiday, :star_grade, :is_recommand, :description,
         :notice, :business_hour_start, :business_hour_end

  expose_qiniu_url :logo

  expose_qiniu_url :images

  expose :first_class, :second_class, using: ShopClassEntity
  expose :distance, safe: true

  expose :is_followed do |shop_obj, options|
    options[:user].present? && options[:user].collections.exists?(object: shop_obj)
  end
end
