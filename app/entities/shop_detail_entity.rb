class ShopDetailEntity < Grape::Entity
  root 'shops'

  expose :id, :name, :lnt, :lng, :address, :telephone,
         :business_on_holiday, :star_grade, :is_recommand, :description,
         :notice, :business_hour_start, :business_hour_end

  expose :logo do |object|
    if object.logo
      Rails.application.config.qiniu_domain + object.logo
    end
  end

  expose :images do |object|
    if object.images
      object.images.map do |image|
        Rails.application.config.qiniu_domain+ image
      end
    end
  end

  expose :first_class, :second_class, using: ShopClassEntity

  expose :is_followed do |shop_obj, options|
    options[:user] && options[:user].collections.exists?(object: shop_obj)
  end
end
