class CouponBasicEntity < Grape::Entity
  expose :id, :name, :cc_type, :min_amount, :cheap, :discount
end
