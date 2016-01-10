class CouponBasicEntity < Grape::Entity
  expose :id, :name, :cc_type, :min_amount, :cheap, :discount
  expose :image do |obj|
    if obj.image
      Rails.application.config.qiniu_domain + obj.image
    end
  end
end
